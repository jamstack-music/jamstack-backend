defmodule Queuehub.Repo do
  use Ecto.Repo,
    otp_app: :queuehub,
    adapter: Ecto.Adapters.Postgres
end
