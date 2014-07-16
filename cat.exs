defmodule CatFinder do

  def cat(scheduler) do
    send scheduler, { :ready, self }
    receive do
      { :perform, filename, client } ->
        send client, { :answer, filename, find_cats(filename), self }
        cat(scheduler)
      { :shutdown } -> exit(0)
    end
  end

  defp find_cats(filename) do
    File.read!(filename)
      |> :binary.matches("cat")
      |> length
  end

end

defmodule Scheduler do

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
      |> Enum.map(fn(_) -> spawn(module, func, [self]) end)
      |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      { :ready, pid } when length(queue) > 0 ->
        [ next | tail ] = queue
        send pid, { :perform, next, self }
        schedule_processes(processes, tail, results)

      { :ready, pid } ->
        send pid, { :shutdown }
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      { :answer, number, result, _pid } ->
        schedule_processes(processes, queue, [ {number, result} | results ])
    end
  end

end

to_process = Enum.map(
  File.ls!("/usr/local/share/man/man3"),
  fn (name) ->
    "/usr/local/share/man/man3/#{name}"
  end
)

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler, :run, [num_processes, CatFinder, :cat, to_process]
  )

  if num_processes == 1 do
    IO.inspect result
    IO.puts "\n # time (s)"
  end
  :io.format "~2B ~.2f~n", [num_processes, time/1000000.0]
end
