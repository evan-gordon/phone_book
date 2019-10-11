use Mix.Config

# Configure your database
config :phone_book, PhoneBook.Repo,
  username: "postgres",
  password: "postgres",
  database: "phone_book_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phone_book, PhoneBookWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
