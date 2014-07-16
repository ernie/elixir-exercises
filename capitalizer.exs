defmodule Capitalizer do

  def capitalize_sentences(string) do
    string
    |> String.split(~r{\.\s+})
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(". ")
  end

end
