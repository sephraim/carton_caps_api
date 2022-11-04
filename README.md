# Carton Caps API

## About

Welcome to the Carton Caps API! You can use this API to access Carton Caps user information,
including user referrals.

Carton Caps is an app that empowers consumers to raise money for the schools they care about,
while buying the everyday products they love.

## Documentation

For a full list of API endpoints and example requests,
please visit the [official API documentation](https://sephraim.github.io/carton_caps_api_docs/).

## Prerequisites

### Project dependencies

All local development and testing is done using Docker,
so the following must be installed on your machine in order to run the API:

- Docker
- Docker Compose

The easiest way to install both of these at once is to install [Docker Desktop](https://www.docker.com/get-started/).

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

### 3. Make a request

Start making requests with your favorite API platform, e.g. Postman, curl, etc. For example:

```bash
GET http://localhost:3000/api/v1/users/1/referees
```
Or just open http://localhost:3000/api/v1/users/1/referees in a web browser.

For a full list of API endpoints and example requests,
please visit the [official API documentation](https://sephraim.github.io/carton_caps_api_docs/).

### 4. Stop & destroy containers

```bash
dev/stop
```

## Run tests

Tests can be run using the following command:

```bash
dev/test
```