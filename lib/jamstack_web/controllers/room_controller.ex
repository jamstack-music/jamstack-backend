defmodule JamstackWeb.RoomController do
  use JamstackWeb, :controller

  alias Jamstack.Rooms
  alias Jamstack.Room

  def show(conn, %{ "id" => id }) do
    case Room.retrieve_state(id) do
      room_state ->
        conn
        |> render("show.json", %{room: room_state})
      {:error, reason} ->
        conn
        |> send_resp(400, reason)
    end
  end
  
  def create(conn, data) do
    case Jamstack.Rooms.Supervisor.create_room(data) do
      {:ok, _pid, room_code} -> 
        conn
        |> send_resp(201, room_code)
      {:error, reason} -> 
        conn
        |> send_resp(400, "Room could not be created")
    end
  end
end
