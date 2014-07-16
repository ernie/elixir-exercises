defmodule StringsAndBinaries do

  def only_printable?([]), do: true
  def only_printable?([head | _])
  when head < 32 or head > ?~
  do
    false
  end

  def only_printable?([_ | tail]), do: true and only_printable?(tail)

  def anagram?(word1, word2) do
    (word1 -- word2) == '' and
      (word2 -- word1) == ''
  end

  def calculate(chars) do
    { rest, number1 }     = parse_number(chars)
    rest                  = skip_spaces(rest)
    { op, rest }          = parse_operator(rest)
    rest                  = skip_spaces(rest)
    { [], number2 }       = parse_number(rest)
    op.(number1, number2)
  end

  defp parse_number(chars), do: _parse_number({chars, 0})

  defp _parse_number({[digit | tail], acc}) when digit in '0123456789' do
    { tail, acc * 10 + digit - ?0 }
  end

  defp _parse_number(result), do: result

  defp skip_spaces([?  | tail]), do: skip_spaces(tail)
  defp skip_spaces(tail),        do: tail

  defp parse_operator([ ?+ | tail ]), do: { &(&1 + &2), tail }
  defp parse_operator([ ?- | tail ]), do: { &(&1 - &2), tail }
  defp parse_operator([ ?* | tail ]), do: { &(&1 * &2), tail }
  defp parse_operator([ ?/ | tail ]), do: { &(div(&1, &2)), tail }

end
