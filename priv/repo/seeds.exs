# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoneBook.Repo.insert!(%PhoneBook.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PhoneBook.Book

people_data = [
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

Enum.each(people_data, fn data ->
  Book.create_person!(data)
end)
