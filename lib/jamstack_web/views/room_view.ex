defmodule JamstackWeb.RoomView do
  use JamstackWeb, :view
  
  def render("show.json", %{room: room}) do
    %{data: render_one(room, JamstackWeb.RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      name: room.name,
      code: room.code,
      members: room.members,
      superBumpEnabled: room.super_bump_enabled,
      queue: room.queue,
      currentSong: room.current_song
    }
  end
end
