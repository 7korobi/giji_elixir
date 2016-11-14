defmodule GijiElixir.Router do
  use GijiElixir.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GijiElixir do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/chats", ChatController
    resources "/users", UserController
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

  defp assign_current(conn, _) do
    assign(conn, :current, get_session(conn, :current))
  end
end
