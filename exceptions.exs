defmodule Exceptions do

  def ok!({:ok, data}), do: data
  def ok!({_, data}), do: raise "#{data}"

end
