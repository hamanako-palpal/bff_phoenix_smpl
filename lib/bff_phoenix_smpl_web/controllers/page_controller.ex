defmodule BffPhoenixSmplWeb.PageController do
  use BffPhoenixSmplWeb, :controller

  def index(conn, _params) do

    StateServer.start_link
    StateServer.login("a", "pw")


    render(conn, "index.html")
  end
end
