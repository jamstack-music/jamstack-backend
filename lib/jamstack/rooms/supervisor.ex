defmodule Jamstack.Rooms.Supervisor do
  use DynamicSupervisor

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end
  
  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
  
  def create_room(room_data) do
    modified_room_data =
      room_data
      |> Map.put("code", create_room_id())

    DynamicSupervisor.start_child(__MODULE__, {Jamstack.Room, modified_room_data})
  end
  
  def destroy_room(room_id) do
    DynamicSupervisor.stop_child(__MODULE__, {:via, Registry, {Jamstack.Rooms.Registry, room_id}})
    Registry.unregister(Jamstack.Rooms.Registry, room_id)
  end
  
  defp create_room_id(retries \\ 5)
  defp create_room_id(0), do: raise RuntimeError, message: "Out of retries"
  defp create_room_id(retries) do
    noun = Jamstack.Dictionary.get_random_noun()
    adjective = Jamstack.Dictionary.get_random_adjective()
    room_id = "#{adjective}-#{noun}"
    
    case Registry.lookup(Jamstack.Rooms.Registry, room_id) do
      [] -> room_id
      _ -> create_room_id(retries - 1)
    end
  end
end
