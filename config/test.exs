use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :giji_elixir, GijiElixir.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :giji_elixir, GijiElixir.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "giji",
  password: "giji",
  database: "giji_elixir_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
