defmodule Searchapp.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :author, :string
      add :body, :string
      add :title, :string
      add :url, :string

      timestamps(type: :utc_datetime)
    end

    # execute "CREATE EXTENSION IF NOT EXISTS pg_trgm;"

    # execute """
    #   CREATE INDEX books_title_gin_trgm_idx
    #     ON books
    #     USING gin (title gin_trgm_ops);
    # """

    execute """
    ALTER TABLE books
      ADD COLUMN searchable tsvector
      GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
        setweight(to_tsvector('english', coalesce(author, '')), 'B') ||
        setweight(to_tsvector('english', coalesce(body, '')), 'C') ||
        setweight(to_tsvector('english', coalesce(url, '')), 'D')
      ) STORED;
  """

  execute """
    CREATE INDEX books_searchable_idx ON books USING gin(searchable);
  """

  end
end
