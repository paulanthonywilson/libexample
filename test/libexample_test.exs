defmodule LibexampleTest do
  use ExUnit.Case
  doctest Libexample

  test "greets the world" do
    assert Libexample.hello() == :world
  end
end
