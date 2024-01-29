ifneq ("$(wildcard /.dockerenv)","") # if in docker
	EXEC_WWW=
else
	EXEC_WWW=docker compose -p symfony70-boilerplate exec php-fpm
endif

BIN_CONSOLE=bin/console --no-debug
VENDOR_CONTAINER=$(shell docker compose ps -q php-fpm)

start:
	docker compose up -d

stop:
	docker compose stop

down:
	docker compose down

build:
	docker compose build --no-cache

restart: stop start

reload: down build start

ps:
	docker compose ps

sh:
	$(EXEC_WWW) /bin/sh

bin-install:
	$(EXEC_WWW) composer bin all install -n --prefer-dist

composer-install:
	$(EXEC_WWW) composer install

composer-validate:
	$(EXEC_WWW) composer validate
