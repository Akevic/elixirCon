defmodule ElixirconTest do
  use ExUnit.Case
  doctest Elixircon

  test "greets the world" do
    assert Elixircon.hello() == :world
  end
end
