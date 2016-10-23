defmodule GitHub do
  @moduledoc """
  An OAuth2 strategy for Github.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [ strategy: GitHub,
      site: "https://api.github.com",
      authorize_url: "https://github.com/login/oauth/authorize",
      token_url: "https://github.com/login/oauth/access_token",

      client_id:     "84286694726079255d7b",
      client_secret: "7f46355177189429c7f5b777d61832939bdcd3dc",
      redirect_uri:  "http://localhost:4000/auth/github/callback"
    ]
  end

  # Public API

  def client do
    config()
    |> OAuth2.Client.new()
  end

  def authorize_url! do
    client()
    |> OAuth2.Client.authorize_url!([])
  end

  def get_token!(code) do
    client()
    |> OAuth2.Client.get_token!(
        client_secret: client().client_secret,
        code: code
      )
  end

  def get_user!(client) do
    %{body: user} = OAuth2.Client.get!(client, "/user")
    %{name: user["name"], avatar: user["avatar_url"]}
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
