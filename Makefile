.DEFAULT_GOAL:=help
SHELL:=/bin/bash

.PHONY: help install start test_setup test

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install:  ## Checks and installs dependencies
	$(info Checking and getting dependencies)
	@docker-compose run --rm back bash -c "bundle check || bundle install"
	@docker-compose run --rm back bash -c "yarn check || yarn install"

start: ## Starts the development server
	$(info Starting the development server)
	@docker-compose run --rm --service-ports back bundle exec rails s -b 0.0.0.0

restart:
	$(info Restarting all the containers and then starting the development server)
	@docker-compose restart
	@docker-compose run --rm --service-ports back bundle exec rails s -b 0.0.0.0

test_setup: install ## Setup the test environment
	$(info Setting up the test environment)
	@docker-compose run --rm back bash -c "RAILS_ENV=test bundle exec rake db:drop db:create environment db:schema:load"

test: ## Starts the test runner
	$(info Running tests)
	@docker-compose run --rm back bundle exec rspec --format documentation
