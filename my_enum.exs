defmodule MyEnum do

  def each(enum, fun) do
    Enum.reduce(enum, [], fn (ele, _acc) ->
      fun.(ele)
    end)
  end

  def filter(enum, fun) do
    Enum.reduce(enum, [], fn (ele, acc) ->
      case fun.(ele) do
      true -> acc ++ [ele]
      _    -> acc
      end
    end)
  end

  def map(enum, fun) do
    Enum.reduce(enum, [], fn (ele, acc) ->
      acc ++ [fun.(ele)]
    end)
  end

end
