# Copyright (C) =:year:=  =:author:=

PROMPT ::= =>
SHELL ::= bash

NOTEBOOK_IMAGE ::= pytorch
NOTEBOOK_VERSION ::= cuda12-python-3.12
# Values: lab (default), notebook, nbclassic
NOTEBOOK_FLAVOR ::= lab
NOTEBOOK_PORT ::= 8888

DATA_DIR ::= data
WORK_DIR ::= work

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: notebook

notebook:
	echo "${PROMPT} Starting the notebook environment"
	@docker container run \
		--rm \
		--tty --interactive \
		--gpus all \
		--user `id --user`:`id --group` \
		--env DOCKER_STACKS_JUPYTER_CMD=${NOTEBOOK_FLAVOR} \
		--volume `pwd`/${DATA_DIR}:/home/jovyan/data \
		--volume `pwd`/${WORK_DIR}:/home/jovyan/work \
		--publish ${NOTEBOOK_PORT}:8888 \
		quay.io/jupyter/${NOTEBOOK_IMAGE}-notebook:${NOTEBOOK_VERSION}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.PHONY: clean mrproper

clean:
	@echo "${PROMPT} Removing all generated files"
	@find . -name .ipynb_checkpoints | xargs rm -rf

mrproper: clean
	@echo "${PROMPT} Cleaning the environment"
