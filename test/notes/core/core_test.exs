defmodule Notes.CoreTest do
  use Notes.DataCase

  alias Notes.Core

  describe "notes" do
    alias Notes.Core.Note

    @valid_attrs %{content: "some content", tags: []}
    @update_attrs %{content: "some updated content", tags: []}
    @invalid_attrs %{content: nil, tags: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Core.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Core.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Core.create_note(@valid_attrs)
      assert note.content == "some content"
      assert note.tags == []
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, note} = Core.update_note(note, @update_attrs)
      assert %Note{} = note
      assert note.content == "some updated content"
      assert note.tags == []
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_note(note, @invalid_attrs)
      assert note == Core.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Core.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Core.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Core.change_note(note)
    end
  end
end
