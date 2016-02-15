defmodule Organism do
  defstruct cells: nil

  def new(data) when is_list(data), do: %Organism{cells: data}

  def alive_neighbors(%Organism{cells: cells}, [x: x, y: y]) do
    for position_x <- (x - 1)..(x + 1),
        position_y <- (y - 1)..(y + 1),
        position_x in 0..(length(cells) - 1) and
        position_y in 0..(length(cells) - 1) and
        not(position_x == x and position_y == y) and
        cell_status(cells, position_x, position_y) == 1
    do
      1
    end
    |> Enum.sum
  end

  def next_generation(%Organism{} = organism, [x: x, y: y] = position) do
    case {cell_status(organism.cells, x, y), alive_neighbors(organism, position)} do
        {1, 2} -> 1
        {1, 3} -> 1
        {0, 3} -> 1
        _ -> 0
    end
  end

  def next(%Organism{} = organism) do
    size = length(organism.cells)
    cells = for x <- 0..(size - 1) do
      for y <- 0..(size - 1) do
        next_generation(organism, [x: x, y: y])
      end
    end
    %Organism{cells: cells}
  end

  def cell_status(cells, x, y) do
    cells
    |> Enum.at(x)
    |> Enum.at(y)
  end

end
