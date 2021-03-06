defmodule Giji.Mixfile do
  use Mix.Project

  def project do
    [app: :giji,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Giji, []},
     applications: [:oauth,
                    :ueberauth_facebook,
                    :ueberauth_google,
                    :ueberauth_github,
                    :ueberauth_slack,
                    :ueberauth_twitter,
                    :cowboy, :logger, :gettext,
                    :phoenix, :phoenix_pubsub, :phoenix_html, :phoenix_ecto,
                    :mariaex, :dogma ]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_slime, ">= 0.8.0"},
     {:gettext, "~> 0.12"},
     {:mariaex, "~> 0.7.7"},
     {:cowboy, "~> 1.0"},
     {:oauth, github: "tim/erlang-oauth"},
     {:ueberauth, "~> 0.2"},
     {:ueberauth_google,   "~> 0.2"},
     {:ueberauth_github,   "~> 0.2"},
     {:ueberauth_identity, "~> 0.2"},
     {:ueberauth_slack,    "~> 0.2"},
     {:ueberauth_twitter,  "~> 0.2"},
     {:ueberauth_facebook, "~> 0.4"},
     {:exq, "~> 0.8.1"},

     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:dogma, ">= 0.0.0", only: [:dev, :test]}
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.migrate", "test"],
     "update": ["archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez"]
    ]
  end
end
