defmodule MyAppWeb.Repo do
  use Ecto.Repo,
    otp_app: :my_app_web,
    adapter: Ecto.Adapters.Postgres
end
