defmodule Queuhub.Rooms.Supervisor do
  use DynamicSupervisor

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end
  
  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
  
  def create_room(room_id) do
    DynamicSupervisor.start_child()
  end
end