NAME ?= elswork/tensorflow-diy
TFVER ?= `cat VERSION-arm32v7`
TFPY ?= cp35
TFPY2 ?= cp27
TFARCH ?= armv7l
TFURL ?= https://www.piwheels.org/simple/tensorflow/tensorflow-$(TFVER)-$(TFPY)-none-linux_$(TFARCH).whl
TFURL2 ?= https://www.piwheels.org/simple/tensorflow/tensorflow-$(TFVER)-$(TFPY2)-none-linux_$(TFARCH).whl

build:
	docker build --no-cache -t $(NAME):amd64 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=amd64-`cat VERSION` . > ../builds/tf-diy_`date +"%Y%m%d_%H%M%S"`.txt
tag:
	docker tag $(NAME):amd64 $(NAME):amd64-`cat VERSION`
push:
	docker push $(NAME):amd64-`cat VERSION`
	docker push $(NAME):amd64	
deploy: build tag push
manifest:
	docker manifest create $(NAME):`cat VERSION` $(NAME):amd64-`cat VERSION` \
	$(NAME):arm32v7-`cat VERSION-arm32v7`
	docker manifest push --purge $(NAME):`cat VERSION`
	docker manifest create $(NAME):latest $(NAME):amd64 $(NAME):arm32v7
	docker manifest push --purge $(NAME):latest
start:
	docker run -it $(NAME):amd64

build-py2:
	docker build --no-cache -t $(NAME):amd64-py2 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=amd64-py2-`cat VERSION` \
    --build-arg PY_VER= . > ../builds/tf-diy-py2_`date +"%Y%m%d_%H%M%S"`.txt
tag-py2:
	docker tag $(NAME):amd64-py2 $(NAME):amd64-py2-`cat VERSION`
push-py2:
	docker push $(NAME):amd64-py2-`cat VERSION`
	docker push $(NAME):amd64-py2	
deploy-py2: build-py2 tag-py2 push-py2
manifest-py2:
	docker manifest create $(NAME):py2-`cat VERSION` $(NAME):amd64-py2-`cat VERSION` \
	$(NAME):arm32v7-py2-`cat VERSION-arm32v7`
	docker manifest push --purge $(NAME):py2-`cat VERSION`
	docker manifest create $(NAME):latest-py2 $(NAME):amd64-py2 $(NAME):arm32v7-py2
	docker manifest push --purge $(NAME):latest-py2
start-py2:
	docker run -it $(NAME):amd64-py2

build-arm:
	docker build --no-cache -t $(NAME):arm32v7 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=arm32v7-`cat VERSION-arm32v7` \
	--build-arg WHL_FILE=$(TFURL) . > ../builds/tf-diy-arm_`date +"%Y%m%d_%H%M%S"`.txt
tag-arm:
	docker tag $(NAME):arm32v7 $(NAME):arm32v7-`cat VERSION-arm32v7`
push-arm:
	docker push $(NAME):arm32v7-`cat VERSION-arm32v7`
	docker push $(NAME):arm32v7	
deploy-arm: build-arm tag-arm push-arm
start-arm:
	docker run -it $(NAME):arm32v7

build-arm-py2:
	docker build --no-cache -t $(NAME):arm32v7-py2 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=arm32v7-py2-`cat VERSION-arm32v7` \
    --build-arg PY_VER= \
	--build-arg WHL_FILE=$(TFURL2) . > ../builds/tf-diy-arm-py2_`date +"%Y%m%d_%H%M%S"`.txt
tag-arm-py2:
	docker tag $(NAME):arm32v7-py2 $(NAME):arm32v7-py2-`cat VERSION-arm32v7`
push-arm-py2:
	docker push $(NAME):arm32v7-py2-`cat VERSION-arm32v7`
	docker push $(NAME):arm32v7-py2	
deploy-arm-py2: build-arm-py2 tag-arm-py2 push-arm-py2
start-arm-py2:
	docker run -it $(NAME):arm32v7-py2
