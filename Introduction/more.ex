defmodule More do

  def append([], y) do y end
  def append([h|t], y) do
    z = append(t, y)
    [h | z]
  end

  def to_binary(0) do [] end
  def to_binary(n) do
    append(to_binary(div(n,2)), [rem(n,2)])
  end

end
