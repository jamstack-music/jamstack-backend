defmodule Jamstack.Room.Server do
  use GenServer
  alias Queuhub.Room
  alias Queuhub.Song
  
  def start_link(_) do
    GenServer.start_link(__MODULE__, %Room{})
  end

  def init(room) do
    {:ok, room}
  end

  def handle_cast({:add_member, member}, _from, state = %Room{ members: members }) do
    {:noreply, %Room{ state | members: [member | members] }}
  end
  
  def handle_cast({:queue_song, song}, _from, state = %Room{ queue: queue }) do
    {:noreply, %Room{ state | queue: queue ++ [song] }}
  end
  
  def handle_cast({:bump_song, song_id}, _from, state = %Room{ queue: queue, super_bump_enabled: true }) do
    queue
    |> Enum.map(song -> possibly_bump_song(song, song_id) end)
    |> Enum.sort((a, b) -> a.bumps > b.bumps)
  end

  def handle_cast({:bump_song, song_id}, _from, state = %Room{ queue: queue }) do
    
  end
  
  defp possibly_bump_song(song = %Song{ uri: song_id, bumps: bumps }, song_id) do
    %Song{ song | bumps: bumps + 1}
  end

  defp possibly_bump_song(song, _), do: song
end
