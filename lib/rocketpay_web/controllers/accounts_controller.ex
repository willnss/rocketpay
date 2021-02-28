defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback RocketpayWeb.FallbackController
  plug :authorize_operation when action in [:withdraw, :deposit]
  plug :authorize_transaction when action in [:transaction]

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %TransactionResponse{} = transaction} <- Rocketpay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end

  defp authorize_operation(conn, _params) do
    %{params: %{"id" => id}} = conn

    if conn.assigns.current_user.account_id == id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> text("")
      |> halt()
    end
  end

  defp authorize_transaction(conn, _params) do
    IO.inspect(conn)
    %{params: %{"from" => id}} = conn

    if conn.assigns.current_user.account_id == id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> text("")
      |> halt()
    end
  end
end
