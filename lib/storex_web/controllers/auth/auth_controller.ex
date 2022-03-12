defmodule StorexWeb.Auth.AuthController do
  use StorexWeb, :controller

  import StorexWeb.Auth.UserAuth

  alias Storex.Accounts

  action_fallback StorexWeb.FallbackController

  plug :require_authenticated_user when action in [:me]

  def me(conn, _params) do
    render(conn, "me.json", user: conn.assigns[:current_user])
  end

  def signup(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.register_user(user_params) do
      conn
      |> log_in_user(user)
      |> render("signup.json", user: user)
    end
  end

  def login(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    with {:ok, user} <- Accounts.get_user_by_email_and_password(email, password) do
      conn
      |> log_in_user(user, user_params)
      |> render("login.json", user: user)
    end
  end
end
