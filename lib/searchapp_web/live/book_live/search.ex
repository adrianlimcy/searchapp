defmodule SearchappWeb.BookLive.Search do
  use SearchappWeb, :live_view

  def mount(_params, _session, socket) do
    search_results = []
    search_phrase = ""
    current_focus = -1

    {:ok,
    socket
    |> assign(:search_results, search_results)
    |> assign(:search_phrase, search_phrase)
    |> assign(:current_focus, current_focus)
    }
  end

end
