defmodule NotesWeb.UserView do
  use NotesWeb, :view
  alias NotesWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("token.json", %{token: token}) do
    %{auth_token: token}
  end

  def render("user.json", %{user: user}) do
    %{email: user.email}
  end
end
