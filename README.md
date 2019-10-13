# PhoneBook

## Installation

You will need to install phoenix and elixir.</br>
A guide for that can be found here: <https://hexdocs.pm/phoenix/installation.html></br>
You will also need npm: <https://www.npmjs.com/get-npm></br>
Lastly you'll need docker compose (for the database): <https://docs.docker.com/compose/install/></br>

## Up and Running

### To start the server

  * Install dependencies with `mix deps.get`
  * Startup the database with `docker-compose up -d postgres`
  * Create and migrate your database with `MIX_ENV=dev mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.</br>
To see a list of routes try `mix phx.routes`</br>

### To run unit tests

  * Create and migrate your database with `MIX_ENV=test mix ecto.setup`
  * Run tests with `mix test` or `mix test --cover` to see code coverage


## Additional Phoenix Resources

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
