defmodule GijiElixir.PageController do
  use GijiElixir.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
