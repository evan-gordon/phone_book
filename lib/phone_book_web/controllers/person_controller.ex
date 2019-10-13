defmodule PhoneBookWeb.PersonController do
  use PhoneBookWeb, :controller

  alias PhoneBook.Book
  alias PhoneBook.Book.Person

  # return up to 10 user id's
  # paginate
  # if more than ten return token for next page info
  @doc """
  If I were building an app that had a focus around many different queries I'd
  likely configure this function to take query params so we could compose a more robust interface.

  Here my requirements were to have 2 different endpoints showing different data formats for the same model.
  I'll route both of those here and then return the right data based on the route
  """
  def index(%Plug.Conn{request_path: "/list"} = conn, %{"token" => token}) do
    # IO.inspect({:received, token})
    # {:ok, decoded_token} = URI.decode(token) |> Base.decode64()
    # {:ok, pagination_data} = PhoneBook.Vault.decrypt(decoded_token)
    # IO.inspect({:found, pagination_data})
    # {:ok, token} = PhoneBook.Vault.encrypt("#{1}:#{2}", :default)
    # encoded_token = Base.encode64(token) |> URI.encode()
    # swap this for query
    with [page, num_per_page] <- String.split(token, "-"),
         {page_int, ""} <- Integer.parse(page),
         {num_per_page_int, ""} <- Integer.parse(num_per_page) do
      assigns =
        PhoneBook.Book.list_paginated_by_age(page_int, num_per_page_int)
        |> create_assigns_from_pagination()

      render(conn, "index.html", assigns)
    else
      _ ->
        render(conn, "index.html", %{people: []})
    end
  end

  def index(%Plug.Conn{request_path: "/list"} = conn, _params) do
    # use actual values here
    # {:ok, token} = PhoneBook.Vault.encrypt("#{1}-#{2}", :default)
    # encoded_token = Base.encode64(token) |> URI.encode()
    # swap this for query
    # IO.inspect({:sent, encoded_token})
    assigns =
      PhoneBook.Book.list_paginated_by_age(1, 10)
      |> create_assigns_from_pagination()

    render(conn, "index.html", assigns)
  end

  def index(conn, _params) do
    people = Book.list_youngest(5)
    render(conn, "index.html", %{people: people})
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

  defp create_assigns_from_pagination(pagination_data) do
    if(pagination_data.page_number < pagination_data.total_pages) do
      %{people: pagination_data.entries, token: "#{pagination_data.page_number + 1}-#{10}"}
    else
      %{people: pagination_data.entries}
    end
  end
end
