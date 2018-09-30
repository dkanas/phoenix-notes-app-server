defmodule Notes.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :content, :string
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
