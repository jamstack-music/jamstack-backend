defmodule Jamstack.Room do
  use GenServer

  defstruct([
    :code,
    :name,
    :current_song,
    super_bump_enabled: false,
    members: [],
    queue: []
  ])
  
  def start_link(room_data = %{"code" => room_id}) do
    case GenServer.start_link(Jamstack.Room.Server, room_data, name: via_tuple(room_id)) do
      {:ok, pid} -> {:ok, pid, room_id}
      {:error, reason} -> raise RuntimeError, message: reason
    end
  end

  def bump_song(room_id, song_id) do
    if exists?(room_id) do
      GenServer.cast(via_tuple(room_id), {:bump_song, song_id})
    else 
      {:error, "Room does not exist"}
    end
  end

  def add_song(room_id, song) do
    if exists?(room_id) do
      GenServer.cast(via_tuple(room_id), {:add_song, song})
    else 
      {:error, "Room does not exist"}
    end
  end

  def add_member(room_id, member) do
    if exists?(room_id) do
      GenServer.cast(via_tuple(room_id), {:add_member, member})
    else 
      {:error, "Room does not exist"}
    end
  end

  def retrieve_state(room_id) do
    if exists?(room_id) do
      GenServer.call(via_tuple(room_id), {:retrieve_state})
    else 
      {:error, "Room does not exist"}
    end
  end
  
  defp via_tuple(room_id) do
    {:via, Registry, {Jamstack.Rooms.Registry, room_id}}
  end

  defp exists?(room_id) do 
    case Registry.lookup(Jamstack.Rooms.Registry, room_id) do
      [] -> false
      _ -> true
    end
  end
end
