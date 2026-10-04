# Infinitune Architecture

Infinitune is a music streaming service based on a microservice architecture.

## Communication

External communication:

Frontend -> REST/JSON -> API Gateway

Internal synchronous communication:

Service -> gRPC -> Service

Internal asynchronous communication:

Service -> Kafka -> Service

## Storage

- PostgreSQL - transactional business data
- Redis - cache and temporary data
- MinIO - audio files and images
- OpenSearch - search index

## Services

### Auth Service

Responsible for:

- registration
- login
- authentication
- access tokens
- refresh tokens
- roles

### User Service

Responsible for:

- user profile
- settings
- preferences

### Catalog Service

Responsible for:

- tracks
- artists
- albums
- genres
- moods
- lyrics

### Playlist Service

Responsible for:

- playlists
- playlist tracks

### Media Service

Responsible for:

- audio storage metadata
- transcoding
- streaming

### Interaction Service

Responsible for:

- track likes
- album likes
- artist follows
- comment likes

### Comment Service

Responsible for:

- comments
- replies
- reports

### History Service

Responsible for:

- listening history

### Recommendation Service

Responsible for:

- personalized recommendations

### Rule Engine

Responsible for:

- dynamic playlist rules

### Content Service

Responsible for:

- music uploads
- releases
- rights
- moderation
