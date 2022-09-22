defmodule MyAppWebWeb.PageController do
  use MyAppWebWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
