defmodule Parrot do

  def start do
    spawn(Parrot, :repeat, ["Squawk!"])
  end

  def repeat(prefix) do
    receive do
      :pine_for_the_fjords -> exit(1)
      message -> IO.puts "#{prefix} #{message}"
    end
    repeat(prefix)
  end

end
