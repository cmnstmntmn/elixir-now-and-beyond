defmodule ClientWeb.Live.GameDisplay do
  use ClientWeb, :live_view

  @topic "Kalahari"

  def mount(_params, _session, socket) do
    if connected?(socket) do
      ClientWeb.Endpoint.subscribe(@topic)
    end

    game = Game.new()
    socket = socket |> assign(%{game: game})
    {:ok, socket}
  end

  def handle_event("make_move", %{"type" => type}, socket) do
    newGame = Game.make_move(socket.assigns.game, action(type))

    ClientWeb.Endpoint.broadcast(@topic, "make_move", newGame)
    {:noreply, assign(socket, :game, newGame)}
  end

  defp action("do_bad"), do: :do_bad
  defp action("do_good"), do: :do_good

  def handle_info(%{event: "make_move", payload: payload}, socket) do
    {:noreply, assign(socket, game: payload)}
  end

  def render(assigns) do
    ~H"""
    	<div class="game-display">
    		<h1>Angels vs. Demons</h1>
    		<%= live_component(__MODULE__.Angels, game: assigns.game, id: 1) %>
    		<%= live_component(__MODULE__.Demons, game: assigns.game, id: 2) %>
    	</div>
    """
  end
end
