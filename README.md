# AWS Data Lake Platform using AWS Glue & Terraform

## Project Overview

This project demonstrates how to build a production-style AWS Data Engineering platform using Infrastructure as Code (Terraform) and AWS Glue for ETL processing.

The objective is to simulate a real-world enterprise data engineering project instead of creating isolated tutorials. Every AWS resource is provisioned using Terraform, ETL jobs are developed in Python, and the entire project follows software engineering best practices including testing, linting, formatting, version control, and CI/CD.

---

# Project Goals

- Build a reusable AWS Data Engineering project.
- Develop AWS Glue ETL jobs using Python.
- Provision infrastructure using Terraform.
- Follow enterprise-level project structure.
- Apply software engineering best practices.
- Maintain the complete project in GitHub.
- Automate deployments through CI/CD.

---

# Architecture

```
                        GitHub
                           │
                           ▼
                     GitHub Actions
                           │
                           ▼
                     Terraform Apply
                           │
       ┌───────────────────┴───────────────────┐
       ▼                                       ▼
    AWS Glue                               IAM Role
       │
       ▼
      S3
 Bronze / Silver / Gold
       │
       ▼
 Glue Data Catalog
       │
       ▼
     Athena
```

---

# Development Workflow

```
VS Code
    │
    ▼
Python Virtual Environment
    │
    ▼
Write Glue ETL Code
    │
    ▼
Black (Formatting)
    │
    ▼
Ruff (Linting & Import Sorting)
    │
    ▼
Pytest (Unit Testing)
    │
    ▼
tox (Automation)
    │
    ▼
Git Commit
    │
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ▼
Terraform Apply
    │
    ▼
Deploy AWS Infrastructure
    │
    ▼
Upload Glue Scripts
    │
    ▼
Run AWS Glue Jobs
    │
    ▼
CloudWatch Logs
```

---

# Project Structure

```
aws-glue-data-platform/

│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── terraform/
│   ├── provider.tf
│   ├── versions.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── iam.tf
│   ├── s3.tf
│   ├── glue.tf
│   ├── crawler.tf
│   ├── athena.tf
│   └── cloudwatch.tf
│
├── glue_jobs/
│   ├── bronze.py
│   ├── silver.py
│   ├── gold.py
│   ├── customer_etl.py
│   └── orders_etl.py
│
├── common/
│   ├── config.py
│   ├── constants.py
│   ├── logger.py
│   └── utils.py
│
├── notebooks/
│   ├── exploration.ipynb
│   └── validation.ipynb
│
├── tests/
│   ├── test_customer.py
│   ├── test_orders.py
│   └── conftest.py
│
├── requirements.txt
├── pyproject.toml
├── tox.ini
├── Makefile
├── .gitignore
└── README.md
```

---

# Folder Explanation

## terraform/

Contains all Infrastructure as Code (IaC).

Resources managed:

- AWS Provider
- IAM Roles
- IAM Policies
- S3 Bucket
- AWS Glue Database
- AWS Glue Jobs
- AWS Glue Crawlers
- CloudWatch Log Groups
- Athena
- EventBridge Scheduler

No infrastructure is created manually.

---

## glue_jobs/

Contains all AWS Glue ETL jobs.

Examples:

- Bronze ingestion
- Silver transformation
- Gold business layer
- Customer ETL
- Order ETL

These scripts execute on AWS Glue (managed Apache Spark).

---

## common/

Reusable project code.

Examples:

- Logger
- Configuration
- Constants
- Utility functions

Avoids code duplication across Glue jobs.

---

## notebooks/

Jupyter notebooks are used only for:

- Data exploration
- Testing
- Debugging
- Validation

Production ETL logic is never written inside notebooks.

---

## tests/

Contains all unit tests.

Tests validate:

- Business logic
- Utility functions
- Data transformations

Testing framework:

Pytest

---

# Development Tools

## Black

Purpose:

Automatically formats Python code.

Benefits:

- Consistent code style
- No formatting discussions
- Easy to read

---

## Ruff

Purpose:

Static code analysis.

Checks:

- Unused imports
- Unused variables
- Code quality
- Import sorting
- Potential bugs

---

## Pytest

Purpose:

Unit testing framework.

Tests verify that ETL functions behave correctly before deployment.

---

## tox

Purpose:

Automation tool.

Running

```
tox
```

automatically performs:

- Create virtual environment
- Install dependencies
- Run Ruff
- Run Black
- Run Pytest

---

## Git

Source code version control.

Tracks every change made to the project.

---

## GitHub

Central repository.

Stores:

- Source code
- Terraform
- Glue jobs
- Documentation

---

## GitHub Actions

Continuous Integration (CI).

Automatically:

- Installs dependencies
- Runs Ruff
- Runs Black
- Executes Pytest
- Validates Terraform

before code is merged.

---

# AWS Services Used

## AWS Glue

Managed Apache Spark service used for ETL processing.

Responsibilities:

- Read data
- Transform data
- Write data

---

## Amazon S3

Data Lake storage.

Structure:

```
easewithdata/

└── dw-with-spark/

    ├── bronze/

    ├── silver/

    ├── gold/

    ├── warehouse/

    ├── scripts/

    └── temp/
```

---

## Glue Data Catalog

Stores metadata.

Examples:

- Databases
- Tables
- Schemas

---

## Athena

Query data stored in S3 using SQL.

---

## CloudWatch

Stores:

- Glue logs
- Errors
- Metrics

Used for monitoring and debugging.

---

## IAM

Controls permissions for:

- Glue
- S3
- CloudWatch
- Athena

---

# Data Pipeline

```
CSV / JSON

      │

      ▼

Amazon S3 (Bronze)

      │

      ▼

AWS Glue

      │

      ▼

Silver Layer

      │

      ▼

Gold Layer

      │

      ▼

Glue Catalog

      │

      ▼

Athena
```

---

# CI/CD Flow

```
Developer

     │

     ▼

VS Code

     │

     ▼

Git Commit

     │

     ▼

GitHub

     │

     ▼

GitHub Actions

     │

     ▼

Run Ruff

     │

     ▼

Run Black

     │

     ▼

Run Pytest

     │

     ▼

Terraform Plan

     │

     ▼

Terraform Apply

     │

     ▼

Deploy Infrastructure

     │

     ▼

Execute Glue Job
```

---

# Learning Objectives

This project demonstrates:

- Python
- AWS Glue
- Apache Spark (through AWS Glue)
- Terraform
- Infrastructure as Code
- Data Lake Architecture
- Bronze / Silver / Gold Layers
- Git & GitHub
- GitHub Actions
- CI/CD
- Unit Testing
- Code Quality
- Cloud Monitoring
- AWS Best Practices

---

# Future Enhancements

- Incremental Loading
- Slowly Changing Dimensions (SCD Type 2)
- Delta Lake
- Apache Iceberg
- Apache Hudi
- Glue Workflows
- Airflow Integration
- Data Quality Framework
- Great Expectations
- Notifications
- Slack Integration
- Cost Monitoring
- Multi-Environment Deployment (Dev / QA / Prod)

---

# Author

Janardhan Reddy

AWS Data Engineering Learning Project

Built to simulate a real-world enterprise data engineering platform using AWS Glue and Terraform.