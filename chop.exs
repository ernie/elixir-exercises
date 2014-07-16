defmodule Chop do
  def guess(actual, low..high \\ 1..1000) do
    do_guess(actual, low + div(high - low, 2), low..high)
  end

  defp do_guess(actual, guess, low..high) do
    IO.puts("Is it #{guess}?")
    check_guess(actual, guess, low..high)
  end

  defp check_guess(actual, guess, _) when actual == guess do
    IO.puts("It is #{guess}!")
  end

  defp check_guess(actual, guess, low.._) when actual < guess do
    guess(actual, low..guess)
  end

  defp check_guess(actual, guess, _..high) when actual > guess do
    guess(actual, guess..high)
  end

end
