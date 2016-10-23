defmodule Facebook do
  @moduledoc """
  An OAuth2 strategy for Facebook.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode

  @config [
    strategy: Facebook,
    site: "https://graph.facebook.com",
    authorize_url: "https://www.facebook.com/dialog/oauth",
    token_url: "/oauth/access_token",

    client_id:     System.get_env("FACEBOOK_CLIENT_ID"),
    client_secret: System.get_env("FACEBOOK_CLIENT_SECRET"),
    redirect_uri:  System.get_env("FACEBOOK_REDIRECT_URI")
  ]

  # Public API
  def client do
    @config
    |> OAuth2.Client.new()
  end

  def authorize_url! do
    client()
    |> OAuth2.Client.authorize_url!(
        scope: "user_photos"
       )
  end

  def get_token!(code) do
    client()
    |> OAuth2.Client.get_token!(
        code: code
      )
  end

  def get_user!(client) do
    {:ok, %{body: user}} = OAuth2.Client.get!(client, "/me", fields: "id,name")
    %{type: "facebook",
      id: user["id"],
      name: user["name"],
      avatar: "https://graph.facebook.com/#{user["id"]}/picture"
    }
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
