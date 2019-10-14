defmodule PhoneBook.Book.Person do
  use Ecto.Schema
  import Ecto.Changeset

  # Supported formats:
  # X-XXX-XXX-XXXX
  # XXX-XXX-XXXX
  @phone_number_formats [
    ~r/^[0-9]{1}-[0-9]{3}-[0-9]{3}-[0-9]{4}$/,
    ~r/^[0-9]{3}-[0-9]{3}-[0-9]{4}$/
  ]

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
    |> validate_length(:name, min: 1)
    |> validate_number(:age, greater_than: 0, less_than: 1000)
    |> validate_phone_number(:phone_number)
  end

  @doc """
  Allowed formats configured at top of file.
  First check if the user input a number, if not return valid.
  Then validate:
  * there are four numbers seperated by dashes
  * each number contains only digits
  * each number contains the correct number of digits
  """
  def validate_phone_number(%Ecto.Changeset{} = changeset, field) when is_atom(field) do
    with {:input_number, phone_number} when is_binary(phone_number) <-
           {:input_number, Map.get(changeset.changes, field)},
         true <-
           Enum.any?(@phone_number_formats, fn regex ->
             Regex.match?(regex, phone_number)
           end) do
      changeset
    else
      {:input_number, nil} ->
        changeset

      _ ->
        changeset
        |> Ecto.Changeset.add_error(field, "Phone number does not match allowed format")
    end
  end
end
