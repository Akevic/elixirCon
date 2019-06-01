defmodule Elixircon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Elixircon.Image{hex: hex}
  end

  def pick_color(image) do
    %Elixircon.Image{hex: [r, g, b | _tail]} = image

    %Elixircon.Image{image | color: {r, g, b}}
  end

  def build_grid(image) do
    %Elixircon.Image{hex: hex} = image
    grid = hex
    |> Enum.chunk_every(4)
    |> Enum.map(&mirror_row/1)
    |> List.flatten
    |> Enum.with_index

    %Elixircon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second, third | _tail] = row
    row ++ [third, second, first]
  end
end
