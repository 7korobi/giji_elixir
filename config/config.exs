# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :giji_elixir,
  ecto_repos: [GijiElixir.Repo]

# Configures the endpoint
config :giji_elixir, GijiElixir.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZvTJtu+zEXJj9w7OwBG3+KRj8o0t0bWF2BSbgtuzlzXLPIQuYwUMLSCNnGy4XJw1",
  render_errors: [view: GijiElixir.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GijiElixir.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
