defmodule PhoneBook.BookTest do
  use PhoneBook.DataCase

  alias PhoneBook.Book

  describe "people" do
    alias PhoneBook.Book.Person

    @valid_attrs %{age: 42, bio: "some bio", name: "some name", phone_number: "some phone_number", photo: "some photo"}
    @update_attrs %{age: 43, bio: "some updated bio", name: "some updated name", phone_number: "some updated phone_number", photo: "some updated photo"}
    @invalid_attrs %{age: nil, bio: nil, name: nil, phone_number: nil, photo: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Book.create_person()

      person
    end

    test "list_people/0 returns all people" do
      person = person_fixture()
      assert Book.list_people() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Book.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = Book.create_person(@valid_attrs)
      assert person.age == 42
      assert person.bio == "some bio"
      assert person.name == "some name"
      assert person.phone_number == "some phone_number"
      assert person.photo == "some photo"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Book.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, %Person{} = person} = Book.update_person(person, @update_attrs)
      assert person.age == 43
      assert person.bio == "some updated bio"
      assert person.name == "some updated name"
      assert person.phone_number == "some updated phone_number"
      assert person.photo == "some updated photo"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Book.update_person(person, @invalid_attrs)
      assert person == Book.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Book.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Book.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Book.change_person(person)
    end
  end
end
