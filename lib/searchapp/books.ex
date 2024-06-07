defmodule Searchapp.Books do
  @moduledoc """
  The Books context.
  """

  import Ecto.Query, warn: false
  alias Searchapp.Repo

  alias Searchapp.Books.Book

  @doc """
  Returns the list of books.

  ## Examples

      iex> list_books()
      [%Book{}, ...]

  """

  def list_books do
    Repo.all(Book)
  end

  def search(""), do: []

  def search(search_phrase) do

    query = from b in Book, select: b.title

    Repo.all(query)
    |> Enum.filter(& matches?(&1, search_phrase))
  end

  def matches?(first, second) do
    String.starts_with?(
      String.downcase(first), String.downcase(second)
    )
  end

  def search_title(title) do
    query = from b in Book, where: b.title == ^title
    Repo.all(query)
  end

  # def search_books(search_word) do
  #   # query = from b in Book, select: b.title == ^search_word
  #   # query = from(b in Book, where: fragment("? % ?", ^search_word, b.title), order_by: {:desc, fragment("? % ?", ^search_word, b.title)})

  #   query = from(b in Book,
  #   where:
  #   fragment(
  #     "searchable @@ websearch_to_tsquery(?)",
  #     ^search_word),
  #   order_by: {
  #     :desc,
  #     fragment(
  #       "ts_rank_cd(searchable, websearch_to_tsquery(?), 4)",
  #       ^search_word
  #       )
  #     }
  #   )

  #   Repo.all(query)
  # end


  @doc """
  Gets a single book.

  Raises `Ecto.NoResultsError` if the Book does not exist.

  ## Examples

      iex> get_book!(123)
      %Book{}

      iex> get_book!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book!(id), do: Repo.get!(Book, id)

  @doc """
  Creates a book.

  ## Examples

      iex> create_book(%{field: value})
      {:ok, %Book{}}

      iex> create_book(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book(attrs \\ %{}) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book.

  ## Examples

      iex> update_book(book, %{field: new_value})
      {:ok, %Book{}}

      iex> update_book(book, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book(%Book{} = book, attrs) do
    book
    |> Book.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book.

  ## Examples

      iex> delete_book(book)
      {:ok, %Book{}}

      iex> delete_book(book)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book(%Book{} = book) do
    Repo.delete(book)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

      iex> change_book(book)
      %Ecto.Changeset{data: %Book{}}

  """
  def change_book(%Book{} = book, attrs \\ %{}) do
    Book.changeset(book, attrs)
  end


  # new lines added

  # def search(""), do: []

  # def search(search_phrase) do

  #   states()
  #   |> Enum.filter(& matches?(&1, search_phrase))
  # end

  # def matches?(first, second) do
  #   String.starts_with?(
  #     String.downcase(first), String.downcase(second)
  #   )
  # end

  # def states() do
    # [
    #   "Alabama", "Alaska", "Arizona", "Arkansas", "California",
    #   "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii",
    #   "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
    #   "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota",
    #   "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
    #   "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota",
    #   "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island",
    #   "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont",
    #   "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"
    # ]

  #   query = from b in Book, select: b.title

  #   Repo.all(query)
  # end
end
