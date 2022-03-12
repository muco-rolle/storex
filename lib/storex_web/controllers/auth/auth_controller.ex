defmodule StorexWeb.Auth.AuthController do
  use StorexWeb, :controller

  alias Storex.Accounts
  alias StorexWeb.Auth.UserAuth

  action_fallback StorexWeb.FallbackController

  def signup(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.register_user(user_params) do
      conn
      |> UserAuth.log_in_user(user)
      |> render("signup.json", user: user)
    end
  end
end
