defmodule My do

  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      if unquote(condition) do
        unquote(else_clause)
      else
        unquote(do_clause)
      end
    end
  end

  defmacro times_n(number) do
    quote do
      def unquote(:"times_#{number}")(n) do
        unquote(number) * n
      end
    end
  end

end

defmodule Explain do

  defmacro __using__(opts) do
    quote do
      import Explain
    end
  end

  defmacro explain(code) do
    IO.inspect code
    # _explain code
  end

end

defmodule Test do
  use Explain

  explain 5 / 5 + 5 / 1
end
