defmodule JamstackWeb.RoomChannel do
  use JamstackWeb, :channel
  alias Phoenix.Socket

  def join("room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      socket_with_room_id =
        socket
        |> assign(:room_id, room_id)
      {:ok, socket_with_room_id}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("add_song", payload, socket = %Socket{ assigns: %{room_id: room_id} }) do
    Jamstack.Room.add_song(room_id, payload)
    broadcast_from socket, "song_added", payload
    {:noreply, socket}
  end

  def handle_in("bump_song", payload, socket = %Socket{ assigns: %{room_id: room_id} }) do
    Jamstack.Room.bump_song(room_id, payload)
    broadcast_from socket, "song_bumped", payload
    {:noreply, socket}
  end

  def handle_in("vote_skip_song", payload, socket = %Socket{ assigns: %{room_id: room_id} }) do
    # TODO: implement
    broadcast_from socket, "song_voted_skip", payload
    {:noreply, socket}
  end

  def handle_in("next_song", _, socket = %Socket{ assigns: %{room_id: room_id} }) do
    # TODO: implement
    broadcast_from socket, "next_song", %{}
    {:noreply, socket}
  end

  def handle_in("add_member", payload = %{"data" => new_member}, socket = %Socket{ assigns: %{room_id: room_id} }) do
    Jamstack.Room.add_member(room_id, new_member)
    broadcast_from socket, "member_added", payload 
    {:noreply, socket}
  end

  def handle_in("play_song", _, socket = %Socket{ assigns: %{room_id: room_id} }) do
    broadcast_from socket, "song_played", %{}
    {:noreply, socket}
  end

  def handle_in("pause_song", _, socket = %Socket{ assigns: %{room_id: room_id} }) do
    broadcast_from socket, "song_paused", %{}
    {:noreply, socket}
  end

  defp authorized?(_payload) do
    true
  end
end
