defmodule Jamstack.Room do
  defstruct(
    :room_code,
    :room_name,
    :current_song,
    super_bump_enabled: false,
    members: [],
    queue: []
  )
end
