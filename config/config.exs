# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phone_book,
  ecto_repos: [PhoneBook.Repo]

# Configures the endpoint
config :phone_book, PhoneBookWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ylu5hkz0syb+0VslrZ9RJ13EggjF1jglF4ywqikTDlBifiQ6L73RyFW21ah7952Q",
  render_errors: [view: PhoneBookWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoneBook.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
