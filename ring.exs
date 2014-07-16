defmodule Ring do

  @interval 2000

  @name :ring

  def start do
    case :global.register_name(@name, self) do
      :yes -> loop(self, :last, :ticking)
      :no  -> join
    end
  end

  def join do
    ring_pid = :global.whereis_name(@name)
    send ring_pid, { :join, self }
    loop ring_pid, :last, :tocking
  end

  def loop(ring_pid, :last, :ticking) do
    receive do
      { :join, client_pid } ->
        loop(ring_pid, client_pid, :ticking)
    after
      @interval ->
        IO.puts "tick -> ringleader"
        send ring_pid, { :tick }
        loop(ring_pid, :last, :tocking)
    end
  end

  def loop(ring_pid, :last, :tocking) do
    receive do
      { :join, client_pid } ->
        loop(ring_pid, client_pid, :tocking)
      { :tick } ->
        IO.puts "tock"
        loop(ring_pid, :last, :ticking)
    end
  end

  def loop(ring_pid, next_pid, :ticking) do
    receive do
      { :join, client_pid } ->
        send next_pid, { :join, client_pid }
        loop(ring_pid, next_pid, :ticking)
    after
      @interval ->
        IO.puts "tick -> #{inspect next_pid}"
        send next_pid, { :tick }
        loop(ring_pid, next_pid, :tocking)
    end
  end

  def loop(ring_pid, next_pid, :tocking) do
    receive do
      { :join, client_pid } ->
        send next_pid, { :join, client_pid }
        loop(ring_pid, next_pid, :tocking)
      { :tick } ->
        IO.puts "tock"
        loop(ring_pid, next_pid, :ticking)
    end
  end

end
