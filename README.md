# Infinitune

Infinitune is a music streaming service with support for:

- music streaming;
- playlists;
- rule-based dynamic playlists;
- likes and artist follows;
- comments;
- listening history;
- personalized recommendations;
- lyrics;
- artist and distributor music uploads.

## Architecture

Backend: Go microservices

Frontend:

- React
- TypeScript
- Vite

Infrastructure:

- PostgreSQL
- Redis
- Kafka
- MinIO
- OpenSearch
- Kong Gateway
- Grafana
- Loki
- Grafana Alloy

## Repository structure

```text
services/       Backend microservices
frontend/       Web frontend
proto/          gRPC contracts
infrastructure/ Infrastructure configuration
docs/           Project documentation
```

## Local infrastructure

Infinitune uses Docker Compose for local infrastructure.

Start:

```bash
make up
```

Check containers:

```bash
make ps
```

Stop:
```bash
make down
```
