defmodule JamstackWeb.Router do
  use JamstackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", JamstackWeb do
    pipe_through :api
  end
end
