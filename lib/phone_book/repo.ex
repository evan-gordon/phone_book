defmodule PhoneBook.Repo do
  use Ecto.Repo,
    otp_app: :phone_book,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
