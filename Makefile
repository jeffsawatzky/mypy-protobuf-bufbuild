.PHONY: build push

PLUGIN_VERSION = 3.2.0
BUF_VERSION = 1
DOCKER_TAG    := v${PLUGIN_VERSION}-${BUF_VERSION}

MYPY_BUF_URL = plugins.buf.build/jeffsawatzky/mypy-protobuf
MYPY_DOCKER_FILE   := Dockerfile.protoc-gen-mypy
MYPY_DOCKER_NAME   := ${MYPY_BUF_URL}
MYPY_DOCKER_IMG    := ${MYPY_DOCKER_NAME}:${DOCKER_TAG}

MYPY_GRPC_BUF_URL = plugins.buf.build/jeffsawatzky/mypy-grpc-protobuf
MYPY_GRPC_DOCKER_FILE   := Dockerfile.protoc-gen-mypy_grpc
MYPY_GRPC_DOCKER_NAME   := ${MYPY_GRPC_BUF_URL}
MYPY_GRPC_DOCKER_IMG    := ${MYPY_GRPC_DOCKER_NAME}:${DOCKER_TAG}

build :
	docker build --build-arg VERSION=${PLUGIN_VERSION} -t ${MYPY_DOCKER_IMG} -f ${MYPY_DOCKER_FILE} .
	docker build --build-arg VERSION=${PLUGIN_VERSION} -t ${MYPY_GRPC_DOCKER_IMG} -f ${MYPY_GRPC_DOCKER_FILE} .

push : build
	docker push ${MYPY_DOCKER_IMG}
	docker push ${MYPY_GRPC_DOCKER_IMG}
