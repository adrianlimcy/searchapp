# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Searchapp.Repo.insert!(%Searchapp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Searchapp.Books

books = [
  %{
    author: "Adam", body: "Something about a body", title: "Adam's Apple", url: "www.test.com"
  },
  %{
    author: "Eve", body: "One rib", title: "Ribbing and Riving", url: "www.test.com"
  },
  %{
    author: "Cain", body: "About impluse and control", title: "How not to", url: "www.test.com"
  },
  %{
    author: "Gandalf", body: "magic magic magic", title: "You shall not pass", url: "www.test.com"
  },
  %{
    author: "Sauron", body: "making rings", title: "Metal Crafting", url: "www.test.com"
  },
]

Enum.each(books, fn(data)->
  Books.create_book(data)
end)
