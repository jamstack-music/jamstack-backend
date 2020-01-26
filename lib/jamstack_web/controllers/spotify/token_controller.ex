defmodule JamstackWeb.Spotify.TokenController do
  use JamstackWeb, :controller

  defp headers do
    [
      {"Authorization", "Basic #{Spotify.encoded_credentials()}"},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]
  end

  def refresh(conn, %{ "refresh_token" => refresh_token }) do
    body = 
      %Spotify.Credentials{ refresh_token: refresh_token }
      |> Spotify.Authentication.body_params()

    case HTTPoison.post("https://accounts.spotify.com/api/token", body, headers) do
      {:ok, %HTTPoison.Response{ status_code: status, body: body }} ->
        conn
        |> send_resp(status, body)
      {:error, message} ->
        conn
        |> send_resp(400, message)
    end
  end
  
  def swap(conn, %{"code" => code}) do
    body = 
      conn
      |> Spotify.Credentials.new()
      |> Spotify.Authentication.body_params(code)

    case HTTPoison.post("https://accounts.spotify.com/api/token", body, headers) do
      {:ok, %HTTPoison.Response{ body: body }} ->
        conn
        |> send_resp(200, body)
      {:error, message} ->
        conn
        |> send_resp(400, message)
    end
  end
end
