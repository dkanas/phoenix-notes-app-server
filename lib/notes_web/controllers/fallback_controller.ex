defmodule NotesWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use NotesWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(NotesWeb.ChangesetView, "error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(NotesWeb.ErrorView, :"404")
  end

  def call(conn, {:error, :unauthenticated}) do
    conn
    |> put_status(:unauthorized)
    |> render(NotesWeb.ErrorView, :"401")
  end
end
