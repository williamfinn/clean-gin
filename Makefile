include .env

RUNNER=docker-compose exec web migrate
ifeq ($(p),host)
	RUNNER=migrate
endif

MIGRATE=$(RUNNER) -path=migration -database "mysql://$(DB_USER):$(DB_PASS)@tcp($(DB_HOST):$(DB_PORT))/$(DB_NAME)" -verbose

migrate-up:
		$(MIGRATE) up
migrate-down:
		$(MIGRATE) down 
force:
		@read -p  "Which version do you want to force?" VERSION; \
		$(MIGRATE) force $$VERSION

goto:
		@read -p  "Which version do you want to migrate?" VERSION; \
		$(MIGRATE) goto $$VERSION

drop:
		$(MIGRATE) drop

create:
		@read -p  "What is the name of migration?" NAME; \
		$(MIGRATE) create -ext sql -seq -dir migration  $$NAME

test:



.PHONY: migrate-up migrate-down force goto drop create test

