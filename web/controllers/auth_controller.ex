defmodule Giji.AuthController do
  use Giji.Web, :controller

  plug :action

  def index(conn, params) do
    # 認証ページへリダイレクトさせます
    module = provider(params)
    conn
    |> redirect(external: module.authorize_url!)
  end

  def delete(conn, params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(conn, params) do
    # 返却されたコードからトークンを取得します
    # アクセストークンを使ってユーザ情報取得 API にリクエストします
    %{"code" => code} = params
    module = provider(params)
    client = module.get_token!(code)
    user = module.get_user!(client)

    current = %{
      user: user,
      token: client.token.access_token
    }
    # ユーザ情報をセッションへ詰めた後、ルートページへリダイレクトさせます
    conn
    |> Phoenix.Token.sign("user token", current.token)

    conn
    |> put_session(:current, current)
    |> redirect(to: "/")
  end

  defp provider(%{"provider" => "github"}),   do: GitHub
  defp provider(%{"provider" => "google"}),   do: Google
  defp provider(%{"provider" => "facebook"}), do: Facebook
  defp provider(%{"provider" => _}), do: raise "No matching provider available"
end
