defmodule RocketpayWeb.Helpers.Authentication do
  alias Rocketpay.Users.Profile.AuthorizedUser

  import Plug.Conn

  def auth_user(conn, _opts) do
    with {user, pass} <- Plug.BasicAuth.parse_basic_auth(conn),
      {:ok, user} <- Rocketpay.is_user_valid?(%{"nickname" => user, "password" => pass}) do
      assign(conn, :current_user,  AuthorizedUser.build(user))
    else
      _ -> conn |> Plug.BasicAuth.request_basic_auth() |> halt()
    end
  end
end
