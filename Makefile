.PHONY: help up down restart build logs ps infra-clean fmt test \
	migrate-auth-up migrate-auth-down migrate-auth-version


ifeq (,$(wildcard ./.env))
	$(error .env file not found. Copy .env.example to .env)
endif

include .env
export

AUTH_DATABASE_URL := postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@$(POSTGRES_HOST):$(POSTGRES_PORT)/auth_db?sslmode=disable


help:
	@echo "Available commands:"
	@echo "  make up           - Start infrastructure"
	@echo "  make down         - Stop infrastructure"
	@echo "  make restart      - Restart infrastructure"
	@echo "  make build        - Build containers"
	@echo "  make logs         - Show container logs"
	@echo "  make ps           - Show container status"
	@echo "  make infra-clean  - Remove containers and volumes"
	@echo "  make fmt          - Format Go services"
	@echo "  make test         - Run Go tests"


up:
	@docker compose up -d


down:
	@docker compose down


restart:
	@docker compose down
	@docker compose up -d


build:
	@docker compose build


logs:
	@docker compose logs -f

logs-postgres:
	@docker compose logs -f postgres

logs-redis:
	@docker compose logs -f redis

logs-kong:
	@docker compose logs -f kong


ps:
	@docker compose ps


infra-clean:
	@docker compose down -v


fmt:
	@for service in services/*; do \
		if [ -f "$$service/go.mod" ]; then \
			echo "Formatting $$service"; \
			(cd $$service && go fmt ./...); \
		fi \
	done


test:
	@for service in services/*; do \
		if [ -f "$$service/go.mod" ]; then \
			echo "Testing $$service"; \
			(cd $$service && go test ./...); \
		fi \
	done


migrate-auth-up:
	@docker compose run --rm migrate \
		-path=/migrations/auth-service/migrations \
		-database="$(AUTH_DATABASE_URL)" \
		up

migrate-auth-down:
	@docker compose run --rm migrate \
		-path=/migrations/auth-service/migrations \
		-database="$(AUTH_DATABASE_URL)" \
		down 1

migrate-auth-version:
	@docker compose run --rm migrate \
		-path=/migrations/auth-service/migrations \
		-database="$(AUTH_DATABASE_URL)" \
		version
