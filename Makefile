.PHONY: help format lint test check clean

help:
	@echo "========================================="
	@echo " AWS Glue Data Platform"
	@echo "========================================="
	@echo ""
	@echo "Available Commands:"
	@echo ""
	@echo " make setup	  -> virtual environment setup"
	@echo " make format   -> Format Python code"
	@echo " make lint     -> Run Ruff linting"
	@echo " make test     -> Run Pytest"
	@echo " make check    -> Run tox"
	@echo " make clean    -> Remove cache files"

setup:

	python3.11 -m venv .venv
	. .venv/bin/activate && pip install -r requirements.txt


format:
	black .

lint:
	ruff check .

test:
	pytest

check:
	tox

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type d -name ".tox" -exec rm -rf {} +