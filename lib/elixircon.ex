defmodule Elixircon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd
    |> build_pixel_map
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

  def filter_odd(image) do
    %Elixircon.Image{grid: grid} = image
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %Elixircon.Image{image | grid: grid}
  end

  def build_pixel_map(image) do
    %Elixircon.Image{grid: grid} = image
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Elixircon.Image{image | pixel_map: pixel_map}
  end
end
