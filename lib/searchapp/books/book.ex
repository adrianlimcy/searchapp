defmodule Searchapp.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :author, :string
    field :body, :string
    field :url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:author, :body, :title, :url])
    |> validate_required([:author, :body, :title, :url])
  end
end
