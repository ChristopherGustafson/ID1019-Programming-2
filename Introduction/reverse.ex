defmodule Reverse do

  def nreverse([]) do [] end
  def nreverse([head | tail]) do
    r = nreverse(tail)
    r ++ [head]
  end

  def reverse([], r) do r end
  def reverse([head | tail], r) do
    reverse(tail, [head | r])
  end

  def bench() do
    ls = [16, 32, 64, 128, 256, 512]
    n = 100
    bench = fn(l) ->
      seq = Enum.to_list(1..l)
      tn = time(n, fn -> nreverse(seq) end)
      tr = time(n, fn -> reverse(seq, []) end)
      :io.format("length: ~10w nrev: ~8w us   rev: ~8w us~n", [l, tn, tr])
    end

    Enum.each(ls, bench)
  end

  def time(n, fun) do
    start = System.monotonic_time(:milliseconds)
    loop(n, fun)
    stop = System.monotonic_time(:milliseconds)
    stop - start
  end

  def loop(n, fun) do
    if n == 0 do
      :ok
    else
      fun.()
      loop(n-1, fun)
    end
  end
end
