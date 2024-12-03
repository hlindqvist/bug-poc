all: client

pdnsapi-spec.yaml:
	curl -k -o pdnsapi-spec.yaml -z pdnsapi-spec.yaml https://raw.githubusercontent.com/PowerDNS/pdns/master/docs/http-api/swagger/authoritative-api-swagger.yaml
	#curl -k -o pdnsapi-spec.yaml -z pdnsapi-spec.yaml https://raw.githubusercontent.com/PowerDNS/pdns/refs/heads/rel/auth-4.9.x/docs/http-api/swagger/authoritative-api-swagger.yaml

pdnsapi-client/setup.py: pdnsapi-spec.yaml
	docker run --rm --user $(shell id -u):$(shell id -g) -v $(shell pwd):/local swaggerapi/swagger-codegen-cli-v3 generate -i /local/pdnsapi-spec.yaml -l python -o /local/pdnsapi-client -c /local/codegen-config.json

pdnsapi-client: pdnsapi-client/setup.py

virtualenv:
	python3 -m venv .venv

client: virtualenv pdnsapi-client requirements.txt
	set -e ; . .venv/bin/activate ; pip install -r requirements.txt

.PHONY : all
