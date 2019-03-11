SNAME ?= tensorflow-diy
NAME ?= elswork/$(SNAME)
BASENAME ?= ubuntu:16.04
VER ?= `cat VERSION`
# Put 3 or leave empty to specify Python3 or Python2
3PY ?= 3
ifeq ($(3PY),3)
	VERPY ?=
	TFPY ?= cp35
else
	VERPY ?= -py2
	TFPY ?= cp27
endif
TFURL ?=tensorflow==$(VER)
ARCH2 ?= armv7l
GOARCH := $(shell uname -m)
ifeq ($(GOARCH),x86_64)
	GOARCH := amd64
#else
	#TFURL := https://www.piwheels.org/simple/tensorflow/tensorflow-$(VER)-$(TFPY)-none-linux_$(ARCH2).whl
endif

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container

debug: ## Debug the container
	docker build -t $(NAME):$(GOARCH)$(VERPY) --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(SNAME)_$(GOARCH)_$(VER)$(VERPY) \
	--build-arg TFVERSION=$(VER) \
	--build-arg WHL_FILE=$(TFURL) \
	--build-arg PY_VER=$(3PY) . 

build: ## Build the container
	docker build --no-cache -t $(NAME):$(GOARCH)$(VERPY) --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(SNAME)_$(GOARCH)_$(VER)$(VERPY) \
	--build-arg TFVERSION=$(VER) \
	--build-arg WHL_FILE=$(TFURL) \
	--build-arg PY_VER=$(3PY) . > ../builds/$(SNAME)_$(GOARCH)_$(VER)$(VERPY)_`date +"%Y%m%d_%H%M%S"`.txt
tag: ## Tag the container
	docker tag $(NAME):$(GOARCH)$(VERPY) $(NAME):$(GOARCH)_$(VER)$(VERPY)
push: ## Push the container
	docker push $(NAME):$(GOARCH)_$(VER)$(VERPY)
	docker push $(NAME):$(GOARCH)$(VERPY)	
deploy: build tag push
manifest: ## Create an push manifest
	docker manifest create $(NAME):$(VER)$(VERPY) $(NAME):$(GOARCH)_$(VER)$(VERPY) $(NAME):$(ARCH2)_$(VER)$(VERPY)
	docker manifest push --purge $(NAME):$(VER)$(VERPY)
	docker manifest create $(NAME):latest$(VERPY) $(NAME):$(GOARCH)$(VERPY) $(NAME):$(ARCH2)$(VERPY)
	docker manifest push --purge $(NAME):latest$(VERPY)
start: ## Start the container
	docker run -it $(NAME):$(GOARCH)$(VERPY)
test: 
	docker run -it --rm $(NAME):$(GOARCH)$(VERPY) \
	python3 -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"