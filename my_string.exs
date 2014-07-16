defmodule MyString do

  def center(strings) do
    center_point = strings
                   |> Enum.map(&String.length/1)
                   |> Enum.max
                   |> div(2)
    Enum.each(strings, fn (string) -> _center(string, center_point) end)
  end

  defp _center(string, center_point) do
    IO.puts(String.rjust(string, center_point + div(String.length(string), 2)))
  end

end
