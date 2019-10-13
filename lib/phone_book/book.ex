defmodule PhoneBook.Book do
  @moduledoc """
  The Book context.
  """

  import Ecto.Query, warn: false
  alias PhoneBook.Repo

  alias PhoneBook.Book.Person

  @doc """
  Returns the list of people.

  ## Examples

      iex> list_people()
      [%Person{}, ...]

  """
  def list_people do
    Repo.all(Person)
  end

  def list_youngest(limit_number) when is_integer(limit_number) do
    from(p in Person,
      where: not is_nil(p.phone_number),
      order_by: p.name,
      limit: ^limit_number
    )
    |> Repo.all()
  end

  def list_paginated_by_age(page, page_size) do
    PhoneBook.Book.Person
    |> select([:id])
    |> order_by(desc: :age)
    |> PhoneBook.Repo.paginate(page: page, page_size: page_size)
  end

  @doc """
  Gets a single person.

  Raises `Ecto.NoResultsError` if the Person does not exist.

  ## Examples

      iex> get_person!(123)
      %Person{}

      iex> get_person!(456)
      ** (Ecto.NoResultsError)

  """
  def get_person!(id), do: Repo.get!(Person, id)

  @doc """
  Creates a person.

  ## Examples

      iex> create_person(%{field: value})
      {:ok, %Person{}}

      iex> create_person(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_person(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Same as `create_person/1` but raises if changeset is invalid
  """
  def create_person!(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a person.

  ## Examples

      iex> update_person(person, %{field: new_value})
      {:ok, %Person{}}

      iex> update_person(person, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_person(%Person{} = person, attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Person.

  ## Examples

      iex> delete_person(person)
      {:ok, %Person{}}

      iex> delete_person(person)
      {:error, %Ecto.Changeset{}}

  """
  def delete_person(%Person{} = person) do
    Repo.delete(person)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking person changes.

  ## Examples

      iex> change_person(person)
      %Ecto.Changeset{source: %Person{}}

  """
  def change_person(%Person{} = person) do
    Person.changeset(person, %{})
  end
end
