# Carton Caps API

## Prerequisites

### Project dependencies

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Initial setup checklist

1. Make sure you have the project dependencies listed above installed on your machine.
2. Clone this repo:
   ```
   git clone git@github.com:sephraim/carton_caps_api.git
   cd carton_caps_api/
   ```
3. Create a `.env` file:
   ```
   cp .env.example .env
   ```
4. Create a MySQL volume:
   ```
   docker volume create carton-caps-api-mysql
   ```

## Getting started

### 1. Build images

```bash
docker compose build
```

### 2. Start containers

```bash
docker compose up -d
```

### 3. Check that it's working

To view the logs, run:
```bash
docker compose logs -f
```

You will know that the API is ready to use when you see the following message:
```
carton-caps-api-web  | * Listening on http://0.0.0.0:3000
carton-caps-api-web  | Use Ctrl-C to stop
```
Press `Ctrl-C` to stop viewing the logs.

### 4. TODO Make a request

### 5. Stop & destroy containers

```bash
docker compose down
```

## TODO: View the docs / make some requests

## TODO: Testing

#### Healthcheck & testing

At this point, the application should now be ready to use, and you can visit the [healthcheck endpoint] to ensure it's working properly.

Additionally, creating a containerized environment for this project is useful for testing and debugging.
You can shell into the `web` container and [run your tests] there.