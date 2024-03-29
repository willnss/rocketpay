defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{User, Account}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Will",
        email: "will@mmmail.com",
        password: "123456",
        nickname: "will",
        age: 27
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)
      credentials = "will:123456"
      conn = put_req_header(conn, "authorization", "Basic #{Base.encode64(credentials)}")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, do a deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{"account" => %{"balance" => "50.00", "id" => _id}, "message" => "Balance changed successfully!"} = response
    end

    test "when there are invalid params, returns an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "orange"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)


      expected_response = %{"message" => "Invalid deposit value!"}
      assert response == expected_response
    end
  end
end
