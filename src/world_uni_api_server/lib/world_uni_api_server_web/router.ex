defmodule WorldUniApiServerWeb.Router do
  use WorldUniApiServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WorldUniApiServerWeb do
    pipe_through :api

    get "/", DefaultController, :index
  end
end
