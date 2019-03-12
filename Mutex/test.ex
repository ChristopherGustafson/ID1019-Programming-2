defmodule Test do

  # Peterson's algorithm
  def lock(id, m, p, q) do
    Cell.set(m, true)
    other = rem(id + 1, 2)
    Cell.set(q, other)

    case Cell.get(p) do
      false ->
        :locked
      true ->
        case Cell.get(q) do
          ^id ->
            :locked
          ^other ->
            lock(id, m, p, q)
        end
    end
  end

  def unlock(_id, m, _p, _q) do
    Cell.set(m, false)
  end

end
