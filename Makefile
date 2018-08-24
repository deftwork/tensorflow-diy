NAME ?= elswork/tensorflow-diy
TFVER ?= 1.9.0
TFPY ?= cp35
TFPY2 ?= cp27
TFARCH ?= armv7l
TFURL ?= https://www.piwheels.org/simple/tensorflow/tensorflow-$(TFVER)-$(TFPY)-none-linux_$(TFARCH).whl
TFURL2 ?= https://www.piwheels.org/simple/tensorflow/tensorflow-$(TFVER)-$(TFPY2)-none-linux_$(TFARCH).whl

build:
	docker build --no-cache -t $(NAME):latest --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=latest-`cat VERSION` . > ../builds/tf-diy_`date +"%Y%m%d_%H%M%S"`.txt
tag:
	docker tag $(NAME):latest $(NAME):latest-`cat VERSION`
push:
	docker push $(NAME):latest-`cat VERSION`
	docker push $(NAME):latest	
deploy: build tag push

build-py2:
	docker build --no-cache -t $(NAME):latest-py2 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=latest-py2-`cat VERSION` \
    --build-arg PY_VER= . > ../builds/tf-diy-py2_`date +"%Y%m%d_%H%M%S"`.txt
tag-py2:
	docker tag $(NAME):latest-py2 $(NAME):latest-py2-`cat VERSION`
push-py2:
	docker push $(NAME):latest-py2-`cat VERSION`
	docker push $(NAME):latest-py2	
deploy-py2: build-py2 tag-py2 push-py2

build-arm:
	docker build --no-cache -t $(NAME):arm32v7 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=arm32v7-`cat VERSION` \
	--build-arg WHL_FILE=$(TFURL) . > ../builds/tf-diy-arm_`date +"%Y%m%d_%H%M%S"`.txt
tag-arm:
	docker tag $(NAME):arm32v7 $(NAME):arm32v7-`cat VERSION`
push-arm:
	docker push $(NAME):arm32v7-`cat VERSION`
	docker push $(NAME):arm32v7	
deploy-arm: build-arm tag-arm push-arm

build-arm-py2:
	docker build --no-cache -t $(NAME):arm32v7-py2 --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg VERSION=arm32v7-py2-`cat VERSION` \
    --build-arg PY_VER= \
	--build-arg WHL_FILE=$(TFURL2) . > ../builds/tf-diy-arm-py2_`date +"%Y%m%d_%H%M%S"`.txt
tag-arm-py2:
	docker tag $(NAME):arm32v7-py2 $(NAME):arm32v7-py2-`cat VERSION`
push-arm-py2:
	docker push $(NAME):arm32v7-py2-`cat VERSION`
	docker push $(NAME):arm32v7-py2	
deploy-arm-py2: build-arm-py2 tag-arm-py2 push-arm-py2
