OUT_DIR = .out
BINARY = $(OUT_DIR)/bootstrap

build:
	@mkdir -p $(OUT_DIR)
	shards install
	docker run --rm -v "${PWD}:/app" crystal-lambda-builder crystal build src/example.cr -o $(BINARY)

package: .out/bootstrap build
	@rm -f lambda.zip
	@zip -j lambda.zip $(BINARY)

deploy: package
	aws lambda update-function-code  \
	--function-name ${FUNCTION_NAME}  \
	--zip-file fileb://lambda.zip \
	--region us-east-1 \
	--profile rd


clean:
	rm -rf $(OUT_DIR) lambda.zip

.PHONY: build package deploy clean
