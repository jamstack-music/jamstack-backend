defmodule JamstackWeb.Plug.SpotifyAuth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, default) do
    case Spotify.Authentication.authenticated?(conn) |> IO.inspect() do
      {:ok, conn} -> 
        conn
        |> halt()
      _ ->
        conn
        |> refresh_tokens()
    end
  end
  
  defp refresh_tokens(conn) do
    case Spotify.Authentication.refresh(conn) do
      {:ok, new_conn} -> new_conn
      :unauthorized ->
        conn
        |> Plug.Conn.send_resp(401, "You must authenticate with Spotify before using this application")
        |> halt()
    end
  end
end
