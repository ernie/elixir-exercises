defmodule SpawnLink do

  def link_to(pid) do
    send pid, "holla back, yo"
    # raise "ZOMG"
    exit(99)
  end

  def do_receive do
    receive do
      msg -> IO.inspect msg
      after 2000 -> exit(0)
    end
    do_receive
  end

end

spawn_link(SpawnLink, :link_to, [self])

:timer.sleep(500)

SpawnLink.do_receive
