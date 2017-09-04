defmodule CookieJarWeb.Router do
  use CookieJarWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CookieJarWeb do
    pipe_through :api

    get "/cookies", ActionController, :cookies
    get "/cat", ActionController, :cat
    get "/grandma", ActionController, :grandma
    get "/monster", ActionController, :monster
  end
end
