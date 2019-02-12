
defmodule Mergesort do

  def msort([]) do [] end
  def msort([x]) do [x] end
  def msort(l) do
    {a, b} = msplit(l, [], [])
    merge(msort(a), msort(b))
  end

  def merge(l, []) do l end
  def merge([], l) do l end
  def merge([h1 | t1], [h2 | t2]) do
    if(h1 < h2) do
      merge([h1 | merge(t1, [h2 | t2])], [])
    else
      merge([], [h2 | merge([h1 | t1], t2)])
    end
  end

  def msplit([], l1, l2) do {l1, l2} end
  def msplit([head | tail], l1 ,l2) do
    msplit(tail , [head | l2], l1)
  end


end
