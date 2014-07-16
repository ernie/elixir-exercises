defmodule Parallel do

  def map(collection, f) do
    me = self

    collection
    |> Enum.map(fn el  -> spawn_link(fn -> send(me, { self, f.(el) }) end) end)
    |> Enum.map(fn pid ->
      receive do
        { ^pid, result } -> result
      end
    end)
  end

end

# Parallel.map 1..1000, &(&1 * &1)
