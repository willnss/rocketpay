defmodule Rocketpay.Users.Authenticate do
  alias Rocketpay.{Repo, User}

  import Ecto.Query, only: [from: 2]

  def call(params) do
    verify_user(params)
  end

  def verify_user(%{"nickname" => nickname, "password" => password}) do
    query = from u in User, where: u.nickname == ^nickname, preload: [:account]

    query
    |> Repo.one()
    |> check_password(password)
  end

  defp check_password(user, password) do
    user |> Bcrypt.check_pass(password)
  end
end
