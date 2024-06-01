# Searchapp

Simple app to try setting up a search bar

Steps:
1. mix phx.new searchapp
2. cd searchapp
3. mix ecto.create
4. modify config/dev.exs to ensure database connection works
5. mix phx.gen.live Books Book books author:string body:string title:string url:string
  - copy and paste routes into router.ex
  - mix ecto.migrate
6. Optional: change the home.html.heex and layouts/app.html.heex to navigate links easier (than typing the url all the time)
7. add data into seeds.exs
8. mix run priv/repo/seeds.exs
9. Read up on this tutorial: https://peterullrich.com/complete-guide-to-full-text-search-with-postgres-and-ecto
10. add lines to migration to ensure postgresql can use the all columns and create a new column called searchable
11. 