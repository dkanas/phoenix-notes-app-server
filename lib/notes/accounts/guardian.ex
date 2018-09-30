defmodule Notes.Accounts.Guardian do
  use Guardian, otp_app: :notes

  alias Notes.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(claims) do
    user = Accounts.get_user(claims["sub"])
    {:ok, user}
  end
end
