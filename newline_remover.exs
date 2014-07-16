defmodule NewlineRemover do

  def process(filename) do
    IO.puts join_with_spaces(split_into_lines(read_file(filename)))
  end

  def read_file(filename) do
    {:ok, contents} = File.read(filename)
    contents
  end

  def split_into_lines(contents) do
    String.split(contents, "\n")
  end

  def join_with_spaces(lines) do
    Enum.join(lines, " ")
  end

end
