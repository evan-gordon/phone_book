defmodule PhoneBook.Book.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :age, :integer
    field :bio, :string
    field :name, :string
    field :phone_number, :string
    field :photo, :string

    timestamps()
  end

  @doc false
  def changeset(%__MODULE__{} = person, attrs) do
    person
    |> cast(attrs, [:name, :age, :phone_number, :photo, :bio])
    |> validate_required([:name, :age])
    |> validate_number(:age, greater_than: 0)
  end
end
