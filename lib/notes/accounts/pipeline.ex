defmodule Notes.Accounts.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :notes,
    error_handler: Notes.Accounts.ErrorHandler,
    module: Notes.Accounts.Guardian

    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    plug Guardian.Plug.LoadResource, allow_blank: true
end
