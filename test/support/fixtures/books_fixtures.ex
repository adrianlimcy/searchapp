defmodule Searchapp.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Searchapp.Books` context.
  """

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        author: "some author",
        body: "some body",
        title: "some title",
        url: "some url"
      })
      |> Searchapp.Books.create_book()

    book
  end
end
