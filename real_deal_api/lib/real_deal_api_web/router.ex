defmodule RealDealApiWeb.Router do
  #alias RealDealApiWeb.DefaultController
  use RealDealApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RealDealApiWeb do
    pipe_through :api

    get "/", DefaultController, :index
  end
end
