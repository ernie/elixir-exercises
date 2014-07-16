defmodule Tick do

  @interval 2000

  @name :ticker

  def start do
    pid = spawn(__MODULE__, :tick, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator([], n) do
    receive do
      { :register, pid } ->
        IO.puts "Registering #{inspect pid}"
        generator([pid], n)
    after
      @interval ->
        IO.puts "tick"
        generator([], n + 1)
    end
  end

  def generator(clients, n) do
    receive do
      { :register, pid } ->
        IO.puts "Registering #{inspect pid}"
        generator(clients ++ [pid], n)
    after
      @interval ->
        IO.puts "tick"
        send Enum.at(clients, rem(n, length(clients))), { :tick }
        generator(clients, n + 1)
    end
  end

end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Tick.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver
    end
  end

end
