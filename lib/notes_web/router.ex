defmodule NotesWeb.Router do
  use NotesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Notes.Accounts.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", NotesWeb do
    pipe_through [:api, :auth, :ensure_auth]

    resources "/notes", NoteController
  end

  scope "/api", NotesWeb do
    pipe_through [:api, :auth]

    post "/login", UserController, :login
    resources "/register", UserController, only: [:create]
  end
end
