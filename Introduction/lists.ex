defmodule Lists do

  def nth(n,l) do

    if n == 1 do
      [a | _] = l
      a
    else
      [_ | l] = l
      nth(n-1, l)
    end
  end

  def len(l) do
    if(l == []) do
      0
    else
      [_ | l] = l
      1 + len(l)
    end
  end

  def sum(l) do
    if(l == []) do
      0
    else
      [a | _] = l
      [_ | l] = l
      a + sum(l)
    end
  end

  def duplicate(l) do
    if(l == []) do
      []
    else
      [head | tail] = l
      [head, head | duplicate(tail)]
    end
  end

  def add(x, []) do [x] end
  def add(x, l) do
    [head | tail] = l
    if(head == x) do
      l
    else
      [head | add(x, tail)]
    end
  end

  def remove(_, []) do [] end
  def remove(x, l) do
    [head | tail] = l
    if(head == x) do
      remove(x, tail)
    else
      [head | remove(x, tail)]
    end
  end

  def unique([]) do [] end
  def unique([head | tail]) do
    [head | unique(remove(head, tail))]
  end

  def reverse([]) do [] end
  def reverse([head | tail]) do
    reverse(tail) ++ [head]
  end

  

end
