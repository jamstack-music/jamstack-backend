defmodule Queuehub.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :code, :string

      timestamps()
    end

  end
end
