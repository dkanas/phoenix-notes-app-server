defmodule NotesWeb.AuthController do
  use NotesWeb, :controller
  
  action_fallback NotesWeb.FallbackController

  alias Notes.Accounts

  def login(conn, %{"email" => email, "password" => password}) do
    Accounts.authenticate_user(email, password) |> login_reply(conn)
  end

  defp login_reply({:ok, user}, conn) do
    IO.inspect user
    text conn, user
  end

  defp login_reply({:error, reason}, conn) do
    text conn, reason
  end
end
