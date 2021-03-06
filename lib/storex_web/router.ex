defmodule StorexWeb.Router do
  use StorexWeb, :router

  import StorexWeb.Auth.UserAuth

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  scope "/api", StorexWeb do
    pipe_through :api

    scope "/auth", Auth do
      get "/me", AuthController, :me
      post "/signup", AuthController, :signup
      post "/login", AuthController, :login
      post "/logout", AuthController, :logout
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
