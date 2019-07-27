defmodule Queuehub.Repo.Migrations.CreateName do
  use Ecto.Migration

  def change do
    create table(:name) do
      add :id, :string

      timestamps()
    end

  end
end
