defmodule StorexWeb.Router do
  use StorexWeb, :router

  import StorexWeb.Auth.UserAuth

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  scope "/api", StorexWeb do
    pipe_through :api

    scope "/auth", Auth, as: :auth do
      post "/signup", AuthController, :signup
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
