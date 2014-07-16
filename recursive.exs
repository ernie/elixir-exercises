defmodule Recursive do

  def fib(0), do: 0
  def fib(1), do: 1
  def fib(2), do: 1
  def fib(n) when n < 0, do: raise "Negative number!"
  def fib(n), do: fib(n-1) + fib(n-2)

end
