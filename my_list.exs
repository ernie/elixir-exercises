defmodule MyList do
  def mapsum([], _), do: 0
  def mapsum([head | tail], fun), do: fun.(head) + mapsum(tail, fun)

  def maximum(list, high \\ 0), do: _maximum(list, high)
  def _maximum([], high), do: high
  def _maximum([head | tail], high) when head > high, do: maximum(tail, head)
  def _maximum([_ | tail], high), do: maximum(tail, high)

  def caesar([], _), do: []
  def caesar([head | tail], n) when (head + n > 122) do
    [96 + rem(head + n, 122) | caesar(tail, n)]
  end
  def caesar([head | tail], n), do: [head + n | caesar(tail, n)]

  def span(from, to) when from > to, do: []
  def span(from, to), do: [from | span(from + 1, to)]
end
