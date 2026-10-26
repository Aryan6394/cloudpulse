.RECIPEPREFIX := >

IMAGE   ?= cloudpulse
TAG     ?= local
CLUSTER ?= cloudpulse

.PHONY: lint test docker kind-up kind-down image-load

lint:
> ruff check .

test:
> python -m pytest -q

docker:
> docker build -t $(IMAGE):$(TAG) --build-arg APP_VERSION=$(TAG) .

kind-up:
> kind create cluster --name $(CLUSTER)

kind-down:
> kind delete cluster --name $(CLUSTER)

image-load: docker
> kind load docker-image $(IMAGE):$(TAG) --name $(CLUSTER)
