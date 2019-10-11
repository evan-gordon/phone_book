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

  scope "/", PhoneBookWeb do
    pipe_through :browser

    get "/", PersonController, :index
    get "/detail/:id", PersonController, :show
  end
end
