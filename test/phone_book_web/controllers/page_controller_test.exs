defmodule PhoneBookWeb.PageControllerTest do
  use PhoneBookWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Phone Book"
  end
end
