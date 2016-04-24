defmodule Talks.PageController do
  use Talks.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
