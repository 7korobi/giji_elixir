use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :giji, Giji.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :giji, Giji.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "giji",
  password: "giji",
  database: "giji_elixir_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
