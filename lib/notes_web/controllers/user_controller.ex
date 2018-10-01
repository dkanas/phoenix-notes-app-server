defmodule NotesWeb.UserController do
  use NotesWeb, :controller

  action_fallback NotesWeb.FallbackController

  alias Notes.Accounts
  alias Notes.Accounts.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn |> put_status(:created) |> render("token.json", token: token)
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, token, _claims} <- Accounts.authenticate_user(email, password) do
      render(conn, "token.json", token: token)
    end
  end
end
