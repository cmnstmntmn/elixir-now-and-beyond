defmodule Game do
  defstruct(
    angels: 0,
    demons: 0
  )

  def new() do
    %__MODULE__{
      angels: 0,
      demons: 0
    }
  end

  def make_move(game, :do_good) do
    %{game | angels: game.angels + 1}
  end

  def make_move(game, :do_bad) do
    %{game | demons: game.demons + 1}
  end
end
