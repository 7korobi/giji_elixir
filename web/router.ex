defmodule GijiElixir.Router do
  use GijiElixir.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GijiElixir do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", GijiElixir do
    pipe_through :browser

    get "/:provider/callback", AuthController, :callback
    get "/:provider",          AuthController, :index
    delete "/logout",          AuthController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api", GijiElixir do
    pipe_through :api
  end

  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
