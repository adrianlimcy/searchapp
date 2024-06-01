defmodule SearchappWeb.BookLiveTest do
  use SearchappWeb.ConnCase

  import Phoenix.LiveViewTest
  import Searchapp.BooksFixtures

  @create_attrs %{title: "some title", author: "some author", body: "some body", url: "some url"}
  @update_attrs %{title: "some updated title", author: "some updated author", body: "some updated body", url: "some updated url"}
  @invalid_attrs %{title: nil, author: nil, body: nil, url: nil}

  defp create_book(_) do
    book = book_fixture()
    %{book: book}
  end

  describe "Index" do
    setup [:create_book]

    test "lists all books", %{conn: conn, book: book} do
      {:ok, _index_live, html} = live(conn, ~p"/books")

      assert html =~ "Listing Books"
      assert html =~ book.title
    end

    test "saves new book", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/books")

      assert index_live |> element("a", "New Book") |> render_click() =~
               "New Book"

      assert_patch(index_live, ~p"/books/new")

      assert index_live
             |> form("#book-form", book: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#book-form", book: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/books")

      html = render(index_live)
      assert html =~ "Book created successfully"
      assert html =~ "some title"
    end

    test "updates book in listing", %{conn: conn, book: book} do
      {:ok, index_live, _html} = live(conn, ~p"/books")

      assert index_live |> element("#books-#{book.id} a", "Edit") |> render_click() =~
               "Edit Book"

      assert_patch(index_live, ~p"/books/#{book}/edit")

      assert index_live
             |> form("#book-form", book: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#book-form", book: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/books")

      html = render(index_live)
      assert html =~ "Book updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes book in listing", %{conn: conn, book: book} do
      {:ok, index_live, _html} = live(conn, ~p"/books")

      assert index_live |> element("#books-#{book.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#books-#{book.id}")
    end
  end

  describe "Show" do
    setup [:create_book]

    test "displays book", %{conn: conn, book: book} do
      {:ok, _show_live, html} = live(conn, ~p"/books/#{book}")

      assert html =~ "Show Book"
      assert html =~ book.title
    end

    test "updates book within modal", %{conn: conn, book: book} do
      {:ok, show_live, _html} = live(conn, ~p"/books/#{book}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Book"

      assert_patch(show_live, ~p"/books/#{book}/show/edit")

      assert show_live
             |> form("#book-form", book: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#book-form", book: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/books/#{book}")

      html = render(show_live)
      assert html =~ "Book updated successfully"
      assert html =~ "some updated title"
    end
  end
end
