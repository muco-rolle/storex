defmodule StorexWeb.Auth.AuthView do
  use StorexWeb, :view

  def render("me.json", %{user: user}) do
    %{status: 200, email: user.email}
  end

  def render("signup.json", %{user: _user}) do
    %{status: 201, message: "User signed up successfully."}
  end

  def render("login.json", %{user: _user}) do
    %{status: 200, message: "User logged in successfully."}
  end
end
