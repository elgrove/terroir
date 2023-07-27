define transcribe
    content=$$( jq -s $(1) $(2) $(3) ) && printf "%s" "$$content" > $(4)
endef

REQUIRED_BINS := poetry jq terraform
$(foreach bin,$(REQUIRED_BINS),\
    $(if $(shell command -v $(bin) 2> /dev/null), \
    	, \
    	$(error Please install `$(bin)`)))

install:
	cd app; poetry install

package: install
	cd app; poetry export --without-hashes --format requirements.txt --output requirements.txt
	cd app; poetry run chalice package --pkg-format terraform ../infra/
	jq 'del(.terraform)' infra/chalice.tf.json > temp.json && mv temp.json infra/chalice.tf.json

init:
	cd infra; terraform init

plan: init
	cd infra; terraform plan

apply:
	cd infra; terraform apply -auto-approve

deploy: package plan apply

destroy:
	cd infra; terraform apply -destroy -auto-approve

clean:
	rm -rf ./app/.chalice/deployments
	rm -rf ./app/requirements.txt
	rm -rf ./infra/chalice.tf.json
	rm -rf ./infra/deployment.zip
	rm -rf ./infra/layer-deployment.zip

purge: destroy clean