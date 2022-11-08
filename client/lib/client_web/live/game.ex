defmodule ClientWeb.Live.GameDisplay do
  use ClientWeb, :live_view

  require EEx

  EEx.function_from_file(
    :def,
    :render,
    "lib/client_web/live/game.ios.heex",
    [:assigns],
    engine: Phoenix.LiveView.HTMLEngine
  )

  # @impl true
  # def render(assigns) do
  #   # render_native(assigns)
  # end

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
end
