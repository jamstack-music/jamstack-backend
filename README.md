# Jamstack

## Requirements
- Docker

^^ That's really it. Everything is going to be managed by docker containers for easy development

## How to start

To start the Jamstack server

  - Build the container with `docker-compose build`
  - Start the docker container with `docker-compose up`
    - Option to pass in `-d` flag to run in detached mode

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Accessing the docker container

- Accessing Logs in detached mode
  - See all logs: `docker-compose logs`
  - See live feed of logs: `docker-compose logs --follow`

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Phoenix Knowledge
  * Docs: https://hexdocs.pm/phoenix
  * Source: https://github.com/phoenixframework/phoenix
