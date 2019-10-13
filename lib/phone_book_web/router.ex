defmodule PhoneBookWeb.Router do
  use PhoneBookWeb, :router

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

  # typically here I would scope through /api/v{version_number}
  scope "/", PhoneBookWeb do
    pipe_through :browser

    resources "/", PersonController, except: [:show]
    # configure endpoints required in problem description
    get "/list", PersonController, :index
    get "/detail/:id", PersonController, :show
  end
end
