defmodule SearchappWeb.BookLive.SearchForm do
  use SearchappWeb, :live_component

  alias Searchapp.Books

  @impl true
  def render(assigns) do
   ~H"""
    <div>
    <.simple_form
        for={}
        id="search_form"
        phx-target={@myself}
        phx-change="search"
        phx-submit="submit"
      >

      <input type="text" class="form-control" name="search_phrase" value={@search_phrase} phx-debounce="500" placeholder="Search..." />

      <%= if @search_results != [] do %>
        <div class="relative" phx-window-keydown="set-focus" phx-target={@myself}>
          <div class="absolute z-50 left-0 right-0 rounded border border-gray-100 shadow py-2 bg-white">
            <%!-- <%= for search_result <- @search_results do %> --%>
            <%!-- <div class="cursor-pointer p-2 hover:bg-gray-200 focus:bg-gray-200" phx-click="pick" phx-value-name={search_result}> --%>
            <%= for {search_result, idx} <- Enum.with_index(@search_results) do %>
              <%= if idx == @current_focus do %>
                <div class="bg-gray-200" phx-click="pick" phx-target={@myself} phx-value-name={search_result}>
                  <%= raw format_search_result(search_result, @search_phrase) %>
                </div>
              <% else %>
                <div class="cursor-pointer p-2 hover:bg-gray-200 focus:bg-gray-200" phx-click="pick" phx-target={@myself} phx-value-name={search_result}>
                  <%= raw format_search_result(search_result, @search_phrase) %>
                </div>
              <% end %>
                <%!-- <%= search_result %> --%>
                <%!-- <%= raw format_search_result(search_result, @search_phrase) %>
              </div> --%>
            <% end %>
          </div>
        </div>
      <% end %>

      <p class="pt-1 text-xs text-gray-700">Search for states</p>
    </.simple_form>
    </div>
    """
  end

  @impl true
  def handle_event("submit", _, socket), do: {:noreply, socket} # PREVENT FORM SUBMIT

  def handle_event("search", %{"search_phrase" => search_phrase}, socket) do

    search_results =  Books.search(search_phrase)
    search_phrase = search_phrase

    {:noreply,
    socket
    |> assign(:search_results, search_results)
    |> assign(:search_phrase, search_phrase)
    }

  end

  def handle_event("pick", %{"name" => search_phrase}, socket) do
    search_results =  []
    search_phrase = search_phrase

    {:noreply,
    socket
    |> assign(:search_results, search_results)
    |> assign(:search_phrase, search_phrase)
    }
  end

  def handle_event("set-focus", %{"key" => "ArrowUp"}, socket) do # UP


    IO.puts "Hello there"

    current_focus =
      Enum.max([(socket.assigns.current_focus - 1), 0])
    {:noreply, assign(socket, current_focus: current_focus)}
  end

  def handle_event("set-focus", %{"key" => "ArrowDown"}, socket) do # DOWN

    current_focus =
      Enum.min([(socket.assigns.current_focus + 1), (length(socket.assigns.search_results)-1)])
    {:noreply, assign(socket, current_focus: current_focus)}

    # {:noreply,
    # socket
    # |> assign(:current_focus, current_focus)
    # }

  end

  def handle_event("set-focus", %{"key" => "Enter"}, socket) do # ENTER

    case Enum.at(socket.assigns.search_results, socket.assigns.current_focus) do
      "" <> search_phrase -> handle_event("pick", %{"name" => search_phrase}, socket)
      _ -> {:noreply, socket}
    end
  end

  def handle_event("set-focus", _, socket), do: {:noreply, socket}


  def format_search_result(search_result, search_phrase) do
    split_at = String.length(search_phrase)
    {selected, rest} = String.split_at(search_result, split_at)

    "<strong>#{selected}</strong>#{rest}"
  end

end
