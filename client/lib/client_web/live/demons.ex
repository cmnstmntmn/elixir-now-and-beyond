defmodule ClientWeb.Live.GameDisplay.Demons do
  use ClientWeb, :live_component

  def mount(socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    	<div>
    	<div class="demons" style={style(@game.angels, @game.demons)}>-</div>
    	<strong><%= assigns.game.demons %></strong>
    	<button phx-click="make_move" phx-value-type="do_bad">Do bad 😈</button>
    	</div>
    """
  end

  defp style(0, 0), do: "width: 0%"

  defp style(angels, demons) do
    total = angels + demons
    percent = (demons / total * 100) |> Float.round(2)

    "width: #{percent}%"
  end
end
