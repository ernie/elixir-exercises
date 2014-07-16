defmodule MySigils do
  def sigil_v(string, _opts) do
    [headers | rows] = string |> String.strip |> String.split("\n")
    headers = String.split(headers, ",")
                |> Enum.map(&binary_to_atom/1)
    rows
      |> Enum.map(fn (line) -> List.zip([headers] ++ [String.split(line, ",")]) end)
  end
end

defmodule Test do
  import MySigils

  def csv(string) do
    ~v/#{string}/
  end
end

IO.inspect Test.csv """
Item,Qty,Price
Teddy bear,4,34.95
Milk,1,2.99
Battery,6,8.00
"""
