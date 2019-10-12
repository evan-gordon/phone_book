defmodule PhoneBookWeb.PersonController do
  use PhoneBookWeb, :controller

  alias PhoneBook.Book
  alias PhoneBook.Book.Person

  # return up to 10 user id's
  # paginate
  # if more than ten return token for next page info
  def index(conn, _params) do
    {:ok, _token} = PhoneBook.Vault.encrypt("#{1}:#{2}", :default)
    people = Book.list_people()
    render(conn, "index.html", people: people)
  end

  def new(conn, _params) do
    changeset = Book.change_person(%Person{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"person" => person_params}) do
    case Book.create_person(person_params) do
      {:ok, person} ->
        conn
        |> put_flash(:info, "Person created successfully.")
        |> redirect(to: Routes.person_path(conn, :show, person))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    person = Book.get_person!(id)
    render(conn, "show.html", person: person)
  end

  def edit(conn, %{"id" => id}) do
    person = Book.get_person!(id)
    changeset = Book.change_person(person)
    render(conn, "edit.html", person: person, changeset: changeset)
  end

  def update(conn, %{"id" => id, "person" => person_params}) do
    person = Book.get_person!(id)

    case Book.update_person(person, person_params) do
      {:ok, person} ->
        conn
        |> put_flash(:info, "Person updated successfully.")
        |> redirect(to: Routes.person_path(conn, :show, person))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", person: person, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    person = Book.get_person!(id)
    {:ok, _person} = Book.delete_person(person)

    conn
    |> put_flash(:info, "Person deleted successfully.")
    |> redirect(to: Routes.person_path(conn, :index))
  end
end
