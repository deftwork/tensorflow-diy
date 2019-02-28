SNAME ?= tensorflow-diy
NAME ?= elswork/$(SNAME)
GOARCH ?= armv7l
#GOARCH ?= amd64
ARCH2 ?= armv7l
VER ?= `cat VERSION`
#VERPY ?=
VERPY ?= -py2
#3PY ?= 3
3PY ?=
#TFPY ?= cp36
TFPY ?= cp27
TFURL ?= https://www.piwheels.org/simple/tensorflow/tensorflow-$(VER)-$(TFPY)-none-linux_$(ARCH2).whl
#TFURL ?=tensorflow==$(VER)

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container

build: ## Build the container
	docker build --no-cache -t $(NAME):$(GOARCH)$(VERPY) --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=$(SNAME)_$(GOARCH)_$(VER)$(VERPY) \
	--build-arg TFVERSION=$(VER) \
	--build-arg WHL_FILE=$(TFURL) \
	--build-arg PY_VER=$(3PY) . > ../builds/$(SNAME)_$(GOARCH)_$(VER)$(VERPY)_`date +"%Y%m%d_%H%M%S"`.txt
tag:
	docker tag $(NAME):$(GOARCH)$(VERPY) $(NAME):$(GOARCH)_$(VER)$(VERPY)
push:
	docker push $(NAME):$(GOARCH)_$(VER)$(VERPY)
	docker push $(NAME):$(GOARCH)$(VERPY)	
deploy: build tag push
manifest:
	docker manifest create $(NAME):$(VER)$(VERPY) $(NAME):$(GOARCH)_$(VER)$(VERPY) $(NAME):$(ARCH2)_$(VER)$(VERPY)
	docker manifest push --purge $(NAME):$(VER)$(VERPY)
	docker manifest create $(NAME):latest$(VERPY) $(NAME):$(GOARCH)$(VERPY) $(NAME):$(ARCH2)$(VERPY)
	docker manifest push --purge $(NAME):latest$(VERPY)
start:
	docker run -it $(NAME):$(GOARCH)$(VERPY)