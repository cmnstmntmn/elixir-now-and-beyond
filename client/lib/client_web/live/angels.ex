defmodule ClientWeb.Live.GameDisplay.Angels do
  use ClientWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    	<div>
    	<div class="angels" style={style(@game.angels, @game.demons)}>-</div>
     	<strong><%= assigns.game.angels %></strong>
     	<button phx-click="make_move" phx-value-type="do_good">Do good 😇</button>
    	</div>
    """
  end

  defp style(0, 0), do: "width: 0%"

  defp style(angels, demons) do
    total = angels + demons
    percent = (angels / total * 100) |> Float.round(2)

    "width: #{percent}%"
  end
end
