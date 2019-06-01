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
    hex
    |> Enum.chunk_every(3)
    |> mirror_row
  end

  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
  end
end
