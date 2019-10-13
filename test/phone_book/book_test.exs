defmodule PhoneBook.BookTest do
  use PhoneBook.DataCase

  alias PhoneBook.Book

  describe "people" do
    alias PhoneBook.Book.Person

    @valid_attrs %{
      age: 42,
      bio: "some bio",
      name: "some name",
      phone_number: "1-234-567-890",
      photo: "some photo"
    }
    @update_attrs %{
      age: 43,
      bio: "some updated bio",
      name: "some updated name",
      phone_number: "1-111-111-111",
      photo: "some updated photo"
    }
    @invalid_attrs %{age: nil, bio: nil, name: nil, phone_number: nil, photo: nil}
    @test_data [
      %{
        name: "Stevo Perry",
        age: 1
      },
      %{
        name: "Billy Gates",
        age: 99,
        phone_number: "1-234-567-890",
        photo: "https://www.example.com/123",
        bio: "Hi I'm totally not the CEO of a multi-billion dollar company."
      },
      %{
        name: "Tommy Cruiseliner",
        age: 999
      },
      %{
        name: "Googley",
        age: 1,
        bio: "I'm a human I swear."
      },
      %{
        name: "John",
        age: 117
      },
      %{
        name: "Totally not a spy",
        age: 555,
        photo: "not found"
      },
      %{
        name: "Merlin",
        age: 100
      },
      %{
        name: "Elvis Parsley",
        age: 84
      },
      %{
        name: "Robert Steel Man",
        age: 45
      },
      %{
        name: "Donny Duckers",
        age: 21
      },
      %{
        name: "Thorium God of Thunder Metals",
        age: 888
      },
      %{
        name: "Band, James Band",
        age: 35
      }
    ]

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
      assert person.phone_number == "1-234-567-890"
      assert person.photo == "some photo"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Book.create_person(@invalid_attrs)
    end

    test "create_person!/1 with invalid data throws error" do
      assert_raise(Ecto.InvalidChangesetError, fn ->
        Book.create_person!(@invalid_attrs)
      end)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, %Person{} = person} = Book.update_person(person, @update_attrs)
      assert person.age == 43
      assert person.bio == "some updated bio"
      assert person.name == "some updated name"
      assert person.phone_number == "1-111-111-111"
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

    test "list_youngest/1 shows only those with phone numbers" do
      people_fixture(@test_data)

      Book.list_youngest(5)
      |> Enum.each(fn person ->
        assert person.phone_number != nil
      end)
    end

    test "list_paginated_by_age/1 returns only user_id" do
      people_fixture(@test_data)

      r = Book.list_paginated_by_age(1, 10)
      assert Enum.at(r.entries, 0).id != nil
      assert Enum.at(r.entries, 0).name == nil
    end

    test "list_paginated_by_age/1 returns only ten if more people exist" do
      people_fixture(@test_data)

      r = Book.list_paginated_by_age(1, 10)
      assert length(r.entries) == 10
    end

    test "list_paginated_by_age/1 returns remaining entries on last page" do
      people_fixture(@test_data)

      r = Book.list_paginated_by_age(2, 10)
      assert length(r.entries) == 2
    end

    def people_fixture(people) do
      Enum.each(people, fn person_attrs ->
        person_fixture(person_attrs)
      end)
    end

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Book.create_person()

      person
    end
  end
end
