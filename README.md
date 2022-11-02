# Carton Caps API

## About

TODO

## Prerequisites

### Project dependencies

All local development and testing is done using Docker,
so the following must be installed on your machine in order to run the API:

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Initial setup checklist

1. Make sure you have the project dependencies listed above installed on your machine.
2. Clone this repo:
   ```bash
   git clone git@github.com:sephraim/carton_caps_api.git
   cd carton_caps_api/
   ```
3. Run the local development setup script:
   ```bash
   dev/app-init
   ```

## Getting started

### 1. Start containers

```bash
dev/start
```

### 2. Check that it's working

To view and follow the logs, run:
```bash
dev/logs
```

You will know that the API is ready to use when you see the following message:
```
carton-caps-api-web  | * Listening on http://0.0.0.0:3000
carton-caps-api-web  | Use Ctrl-C to stop
```
Press `Ctrl-C` to stop viewing the logs.

### 3. TODO Make a request

### 4. Stop & destroy containers

```bash
dev/stop
```

## View the docs / make some requests

TODO

## Run tests

Tests can be run using the following command:

```bash
dev/test
```