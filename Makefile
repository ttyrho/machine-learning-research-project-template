# Copyright (C) 2025 Cesar Perez

PROMPT ::= =>
SHELL ::= bash

SERVICE_PORT = `grep SERVICE_PORT .env | cut --delimiter=' ' --field=3`
NOTEBOOK_TOKEN = `grep NOTEBOOK_TOKEN .env | cut --delimiter=' ' --field=3`

JUPYTER_HOST = `grep NOTEBOOK_HOST .env | cut --delimiter=' ' --field=3`
JUPYTER_URL = http://jupyter.localhost:${SERVICE_PORT}?token=${NOTEBOOK_TOKEN}"

MLFLOW_HOST = `grep MLFLOW_HOST .env | cut --delimiter=' ' --field=3`
MLFLOW_URL = http://mlflow.localhost:${SERVICE_PORT}"

RUNS_DIR ::= runs
WORK_DIR ::= work

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: setup

runs:
	@echo "${PROMPT} Creating the directory for MLflow runs"
	@mkdir --parents ${RUNS_DIR}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: start stop

start: runs
	@echo "${PROMPT} Starting the development environment"
	@docker compose up --detach --remove-orphans
	@echo "${PROMPT} Jupyter at ${JUPYTER_URL}
	@echo "${PROMPT} MLflow at ${MLFLOW_URL}


stop:
	@echo "${PROMPT} Stoping the development environment"
	@docker compose down --remove-orphans

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: clean mrproper

clean:
	@echo "${PROMPT} Cleaning the enviroment"
	@find . -name .ipynb_checkpoints | xargs rm --recursive --force

mrproper: clean
	@echo "${PROMPT} Purging all generated files"
	@rm --recursive --force ${RUNS_DIR}
