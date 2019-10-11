defmodule PhoneBook.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      PhoneBook.Repo,
      PhoneBook.Vault,
      PhoneBookWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: PhoneBook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    PhoneBookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
