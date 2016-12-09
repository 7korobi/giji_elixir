defmodule Giji.AuthController do
  use Giji.Web, :controller
  plug Ueberauth

  alias Giji.{User}
  alias Ueberauth.Strategy.Helpers

  def delete(conn, params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end



  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case UserFromAuth.find_or_create(auth) do
      {:ok, user}->
        IO.inspect auth.credentials
        IO.inspect user
        current = %{
          user: user,
          token: auth.credentials.token
        }
        IO.inspect current
        # Phoenix.Token.sign(Giji.Endpoint, "user token", token)

        conn
        |> put_session(:current, current)
        |> put_flash(:info, "Success.")
        |> redirect(to: "/")
      {:error, reason}->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
