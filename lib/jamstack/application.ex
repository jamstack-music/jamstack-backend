defmodule Jamstack.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: Jamstack.Rooms.Registry },
      Jamstack.Rooms.Supervisor,
      JamstackWeb.Endpoint,
      Jamstack.Dictionary
    ]

    opts = [strategy: :one_for_one, name: Jamstack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    JamstackWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
