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

config :oauth2, GitHub,
  client_id:     "84286694726079255d7b",
  client_secret: "7f46355177189429c7f5b777d61832939bdcd3dc",
  redirect_uri:  "http://localhost:4000/auth/github/callback"

config :oauth2, Google,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")

config :oauth2, Facebook,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET"),
  redirect_uri: System.get_env("FACEBOOK_REDIRECT_URI")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

