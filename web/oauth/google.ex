defmodule Google do
  @moduledoc """
  An OAuth2 strategy for Google.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  defp config do
    [ strategy: Google,
      site: "https://accounts.google.com",
      authorize_url: "/o/oauth2/auth",
      token_url: "/o/oauth2/token",

      client_id:     "54633717694-1dkecjrffgpa1ua9jgcdmemfcv58dusl.apps.googleusercontent.com",
      client_secret: "wPgQu4GB80Kj4Y8_HWpTtvFa",
      redirect_uri:  "http://lvh.me:4000/auth/google/callback"
    ]
  end

  # Public API

  def client do
    config()
    |> OAuth2.Client.new()
  end

  def authorize_url! do
    client()
    |> OAuth2.Client.authorize_url!(
        scope: "https://www.googleapis.com/auth/userinfo&response_type=code"
       )
  end

  def get_token!(code) do
    client()
    |> OAuth2.Client.get_token!(
        code: code
      )
  end

  def get_user!(client) do
    {:ok, %{body: user}} = OAuth2.Client.get!(client, "https://www.googleapis.com/plus/v1/people/me/openIdConnect")
    %{name: user["name"], avatar: user["picture"]}
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
