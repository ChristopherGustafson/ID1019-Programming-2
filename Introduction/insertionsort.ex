defmodule Insertionsort do

  def insert(e, []) do [e] end
  def insert(e, [head | tail]) do
    if(e < head) do
      [e, head | tail]
    else
      [head | insert(e, tail)]
    end
  end

  def isort([head | tail]) do
    isort(tail, [head])
  end
  def isort([], sorted) do sorted end
  def isort([head | tail], sorted) do
    isort(tail, insert(head, sorted))
  end
end
