.PHONY: help fmt test

help:
	@echo "Available commands:"
	@echo "  make fmt   - format Go code"
	@echo "  make test  - run test"

fmt:
	@for service in services/*; do \
		if [ -f "$$service/go.mod" ]; then \
			echo "Fromatting $$service"; \
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
