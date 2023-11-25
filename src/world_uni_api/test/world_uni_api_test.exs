defmodule WorldUniApiTest do
  use ExUnit.Case
  doctest WorldUniApi

  test "greets the world" do
    assert WorldUniApi.hello() == :world
  end
end
