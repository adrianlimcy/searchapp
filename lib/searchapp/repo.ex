defmodule Searchapp.Repo do
  use Ecto.Repo,
    otp_app: :searchapp,
    adapter: Ecto.Adapters.Postgres
end
