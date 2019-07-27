defmodule Queuehub.Repo.Migrations.CreateName do
  use Ecto.Migration

  def change do
    create table(:name) do
      add :code, :string
      add :private, :boolean, default: false, null: false

      timestamps()
    end

  end
end
