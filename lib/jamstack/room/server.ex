defmodule Jamstack.Room.Server do
  alias Jamstack.Room
  alias Jamstack.Song
  
  def init(room_data) do
    code = room_data |> Map.get("code")
    name = room_data |> Map.get("name")

    {:ok, %Room{ code: code, name: name }}
  end

  def handle_cast({:add_member, member}, state = %Room{ members: members }) do
    {:noreply, %Room{ state | members: [member | members] }}
  end
  
  def handle_cast({:queue_song, song}, state = %Room{ queue: queue }) do
    {:noreply, %Room{ state | queue: queue ++ [song] }}
  end
  
  def handle_cast({:bump_song, song_id}, state = %Room{ queue: queue, super_bump_enabled: true }) do
    new_queue =
      queue
      |> Enum.map(fn song -> possibly_bump_song(song, song_id) end)
      |> Enum.sort(fn (a, b) -> a.bumps > b.bumps end)
  
    {:noreply, %Room{ state | queue: new_queue }}
  end

  def handle_cast({:bump_song, song_id}, state = %Room{ queue: queue }) do
    new_queue = 
      queue
      |> bump_song(song_id)

    {:noreply, %Room{ state | queue: new_queue }}
  end
  
  def handle_call({:retrieve_state}, _from, state) do
    {:reply, state, state}
  end

  ## Helper functions ##

  defp possibly_bump_song(song = %Song{ uri: song_id, bumps: bumps }, song_id) do
    %Song{ song | bumps: bumps + 1}
  end

  defp possibly_bump_song(song, _), do: song
  
  defp bump_song([h | []], _), do: [h]
  defp bump_song([other, song = %Song{uri: song_id} | tail], song_id), do: [song_id, other | tail]
  defp bump_song([head, next | tail], song_id), do: [head, next | bump_song(tail, song_id)]
end
