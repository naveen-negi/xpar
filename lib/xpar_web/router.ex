defmodule XparWeb.Router do
  use XparWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", XparWeb do
  #   pipe_through :browser # Use the default browser stack

    # get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  scope "/api", XparWeb do
    pipe_through :api
    get "teams/:id/pairing-matrix", PairController, :get
    get "/teams/:id/repos", TeamsController, :get
    post "/teams/:id/repos", TeamsController, :create
  end
end
