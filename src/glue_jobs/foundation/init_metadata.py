import logging
import sys

from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext

# ------------------------------------------------------------------------------
# Logging
# ------------------------------------------------------------------------------

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")

logger = logging.getLogger(__name__)
logger.info("Starting Metadata Initialization Job.")

# ------------------------------------------------------------------------------
# Read Glue Job Parameters
# ------------------------------------------------------------------------------

args = getResolvedOptions(sys.argv, ["JOB_NAME", "bucket_name", "metadata_database"])

bucket_name = args["bucket_name"]
metadata_database = args["metadata_database"]

# ------------------------------------------------------------------------------
# Initialize Spark / Glue
# ------------------------------------------------------------------------------

sc = SparkContext.getOrCreate()
glue_context = GlueContext(sc)
spark = glue_context.spark_session

job = Job(glue_context)
job.init(args["JOB_NAME"], args)

logger.info("Bucket Name      : %s", bucket_name)
logger.info("Metadata Database: %s", metadata_database)

# ------------------------------------------------------------------------------
# Use Metadata Database
# ------------------------------------------------------------------------------

try:
    spark.sql(f"USE {metadata_database}")
    logger.info("Using metadata database: %s", metadata_database)

except Exception:
    logger.exception("Unable to use metadata database: %s", metadata_database)
    raise

# ------------------------------------------------------------------------------
# Create ETL Job Control Table
# ------------------------------------------------------------------------------

job_control_table = f"""
CREATE TABLE IF NOT EXISTS {metadata_database}.etl_job_control (
    job_name STRING,
    layer STRING,
    source_name STRING,
    target_name STRING,
    last_processed_timestamp TIMESTAMP,
    last_batch_id STRING,
    last_run_status STRING,
    last_successful_run TIMESTAMP,
    updated_at TIMESTAMP
)
USING DELTA
LOCATION 's3://{bucket_name}/metadata/etl_job_control/'
"""

try:
    logger.info("Creating etl_job_control table...")
    spark.sql(job_control_table)
    logger.info("etl_job_control table created successfully.")

except Exception:
    logger.exception("Failed to create etl_job_control table.")
    raise

# ------------------------------------------------------------------------------
# Create ETL Job Audit Table
# ------------------------------------------------------------------------------

job_audit_table = f"""
CREATE TABLE IF NOT EXISTS {metadata_database}.etl_job_audit (
    run_id STRING,
    pipeline_name STRING,
    job_name STRING,
    layer STRING,
    job_status STRING,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    records_read BIGINT,
    records_written BIGINT,
    error_message STRING,
    created_at TIMESTAMP
)
USING DELTA
LOCATION 's3://{bucket_name}/metadata/etl_job_audit/'
"""

try:
    logger.info("Creating etl_job_audit table...")
    spark.sql(job_audit_table)
    logger.info("etl_job_audit table created successfully.")

except Exception:
    logger.exception("Failed to create etl_job_audit table.")
    raise

# ------------------------------------------------------------------------------
# Commit Job
# ------------------------------------------------------------------------------

try:
    job.commit()
    logger.info("Metadata initialization completed successfully.")

except Exception:
    logger.exception("Failed to commit Glue job.")
    raise
