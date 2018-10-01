defmodule Notes.Accounts.ErrorHandler do
  import Plug.Conn

  def auth_error(_conn, _data, _reason, _opts) do
    {:error, :unauthenticated}
  end
end
