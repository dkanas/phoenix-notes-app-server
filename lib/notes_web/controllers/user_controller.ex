defmodule NotesWeb.UserController do
  use NotesWeb, :controller

  action_fallback NotesWeb.FallbackController

  alias Notes.Accounts
  alias Notes.Accounts.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
