defmodule WorldUniApiServerWeb.DefaultController do
  use WorldUniApiServerWeb, :controller # Get stuff for/from controllers

  def index(conn, _params) do
    text conn, "Hello, Mom! - #{Mix.env()}"
  end
end
