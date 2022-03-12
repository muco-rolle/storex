defmodule Storex.Repo do
  use Ecto.Repo,
    otp_app: :storex,
    adapter: Ecto.Adapters.Postgres
end
