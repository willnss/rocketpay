defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView

  import Phoenix.View

  test "rtenders create.json" do
    params = %{
      name: "Will",
      email: "will@mmmail.com",
      password: "123456",
      nickname: "will",
      age: 27
    }

    {:ok, %User{ id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.Users.Create.call(params)

    response = render(UsersView, "create.json", user: user)
    expected_response = %{message: "User created", user: %{account: %{balance: Decimal.new("0.00"), id: account_id}, id: user_id, name: "Will", nickname: "will"}}

    assert expected_response == response
  end
end
