defmodule FizzBuzz do

  def upto(n) when n > 0 do
    1..n |> Enum.map(&_upto/1)
  end

  defp _upto(n) do
    case n do
      _ when rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
      _ when rem(n, 3) == 0 -> "Fizz"
      _ when rem(n, 5) == 0 -> "Buzz"
      n -> n
    end
  end

end
