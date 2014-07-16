defmodule Actor do

  def token(listener, sleep_for \\ 0) do
    receive do
      token ->
        :timer.sleep(sleep_for)
        send listener, {self, token}
    end
  end

end

fred  = spawn(Actor, :token, [self, 500])
betty = spawn(Actor, :token, [self])

send(fred, "fred")
send(betty, "betty")

receive do
  {^fred, token} -> IO.puts token
end

receive do
  {^betty, token} -> IO.puts token
end
