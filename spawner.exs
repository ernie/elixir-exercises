defmodule Spawner do

  def async_print(output) do
    spawn(fn -> IO.puts(output) end)
  end

  def async_print_error(output) do
    spawn(
      fn ->
        raise "OH NOES!"
        IO.puts(output)
      end
    )
  end

  def async_print_linked(output) do
    spawn_link(
      fn ->
        raise "OH NOES!"
        IO.puts(output)
      end
    )
  end

  def async_print_monitor(output) do
    spawn_monitor(
      fn -> raise output end
    )
    receive do
      {:DOWN, _ref, :process, _pid, {%RuntimeError{message: message}, _info}} ->
        IO.puts message
    end
  end

end
