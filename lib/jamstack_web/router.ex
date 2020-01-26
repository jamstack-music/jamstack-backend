defmodule JamstackWeb.Router do
  use JamstackWeb, :router

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:8080"]
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug JamstackWeb.Plug.SpotifyAuth
  end
  
  scope "/v1", JamstackWeb do
    pipe_through :api

    get "/rooms/:id", RoomController, :show
    post "/rooms", RoomController, :create
    options "/rooms/:id", RoomController, :options
    options "/rooms", RoomController, :options

    get "/spotify/authorize", Spotify.AuthController, :authorize
    get "/spotify/authenticate", Spotify.AuthController, :authenticate
    
    post "/spotify/tokens/refresh", Spotify.TokenController, :refresh
    post "/spotify/tokens/swap", Spotify.TokenController, :swap
  end
end
