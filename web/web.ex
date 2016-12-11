defmodule Giji.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Giji.Web, :controller
      use Giji.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """

  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Giji.Repo
      import Ecto
      import Ecto.Query

      import Giji.Router.Helpers
      import Giji.Gettext
    end
  end

  def api_controller do
    quote do
      use Phoenix.Controller

      alias Giji.Repo
      import Ecto
      import Ecto.Query

      import Giji.Router.Helpers
      import Giji.Gettext
      def render_error(conn, cs, at) do
        conn
        |> put_status(:unprocessable_entity)
        |> render(Giji.ChangesetView, "error.json", changeset: cs, at: at)
      end
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import Giji.Router.Helpers
      import Giji.ErrorHelpers
      import Giji.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Giji.Repo
      import Ecto
      import Ecto.Query
      import Giji.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
