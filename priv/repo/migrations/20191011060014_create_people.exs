defmodule PhoneBook.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :name, :string, null: false
      add :age, :integer, null: false
      add :phone_number, :string, size: 20
      add :photo, :string
      add :bio, :string

      timestamps()
    end
  end
end
