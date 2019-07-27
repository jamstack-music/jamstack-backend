defmodule QueuehubWeb.Router do
  use QueuehubWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", QueuehubWeb do
    pipe_through :api

  end

end
