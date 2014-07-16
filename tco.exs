defmodule TCO do

  def fib(0), do: 0
  def fib(1), do: 1
  def fib(2), do: 1
  def fib(n) when n < 0, do: raise "Negative number!"
  def fib(n), do: fib(n, 1, 1)

  defp fib(3, previous, current), do: previous + current
  defp fib(n, previous, current), do: fib(n - 1, current, previous + current)

end
