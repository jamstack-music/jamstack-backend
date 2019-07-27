defmodule Queuehub.Rooms.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :spotify_id, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :spotify_id])
    |> validate_required([:name, :spotify_id])
  end
end
