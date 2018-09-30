defmodule Notes.Core.Note do
  use Ecto.Schema
  import Ecto.Changeset


  schema "notes" do
    field :content, :string
    field :tags, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:content, :tags])
    |> validate_required([:content, :tags])
  end
end
