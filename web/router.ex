defmodule Giji.Router do
  use Giji.Web, :router

  @moduledoc """
    web route set
  """

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

  scope "/", Giji do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/auth", Giji do
    pipe_through :browser

    get    "/logout",           AuthController, :delete
    delete "/logout",           AuthController, :delete
    get  "/:provider",          AuthController, :request
    get  "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  scope "/api", Giji do
    pipe_through :api
    resources "/books",  BookController
    resources "/chats",  ChatController,  except: [:index, :show]
    resources "/potofs", PotofController, except: [:index, :show]

    case Mix.env do
      :dev  -> post "/auth", AuthController, :force
      :test -> post "/auth", AuthController, :force
      :prod -> nil
    end
  end

  scope "/api/:section_id", Giji do
    pipe_through :api
    resources "/chats", ChatController, only: [:index]

    # resources "/parts",    PartController
    # resources "/sections", SectionController
    # resources "/phases",   PhaseController
    # resources "/cards",    CardController
  end

  scope "/api/:book_id/:part_id", Giji do
    pipe_through :api
  end

  defp assign_current(conn, _) do
    assign(conn, :current, get_session(conn, :current))
  end
end
