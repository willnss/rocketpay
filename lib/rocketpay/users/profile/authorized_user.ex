defmodule Rocketpay.Users.Profile.AuthorizedUser do
  alias Rocketpay.{User, Account}

  defstruct [:user_id, :account_id]

  def build(%User{id: user_id, account: %Account{id: account_id}}) do
    %__MODULE__{
      user_id: user_id,
      account_id: account_id
    }
  end
end
