defmodule NotesWeb.NoteController do
  use NotesWeb, :controller

  alias Notes.Core
  alias Notes.Core.Note

  action_fallback NotesWeb.FallbackController

  def index(conn, params) do
    notes = Core.list_notes(params)
    render(conn, "index.json", notes: notes)
  end

  def create(conn, %{"note" => note_params}) do
    with {:ok, %Note{} = note} <- Core.create_note(note_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", note_path(conn, :show, note))
      |> render("show.json", note: note)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Core.get_note!(id)
    render(conn, "show.json", note: note)
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = Core.get_note!(id)

    with {:ok, %Note{} = note} <- Core.update_note(note, note_params) do
      render(conn, "show.json", note: note)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Core.get_note!(id)
    with {:ok, %Note{}} <- Core.delete_note(note) do
      send_resp(conn, :no_content, "")
    end
  end
end
