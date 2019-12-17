.PHONY: help
.DEFAULT_GOAL := help

DOCKER=$(shell which docker)
AWS=$(aws2)
REPOSITORY?=farmshelf/mosquitto
VERSION?=v1.6.4
ECR_REPO?=667730253213.dkr.ecr.us-east-1.amazonaws.com/farmshelf/mosquitto

TAG?=latest

image: ## build the docker image from Dockerfile
	$(DOCKER) build --no-cache -t ${REPOSITORY}:${TAG} \
        --build-arg VERSION=${TAG} \
        --build-arg VCS_REF=`git rev-parse --short HEAD` \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` .

login: ## Login to aws ecr
	$$(aws2 ecr get-login --no-include-email)

ecr_tag: ## Tag image in AWS ECR
	$(DOCKER) tag ${REPOSITORY} ${ECR_REPO}\:${TAG}

push: login ## Push latest image to ECR
	$(DOCKER) push ${ECR_REPO}:${TAG}

build_push: image ecr_tag push ## Build, tag, and push to ECR

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
