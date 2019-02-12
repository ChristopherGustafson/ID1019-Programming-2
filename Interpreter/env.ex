defmodule Env do

  def new() do
    []
  end

  def add(id, str, env) do
    [{id, str} | env]
  end

  def lookup(_, []) do nil end
  def lookup(id, [{id, s} | _]) do {id, s} end
  def lookup(id, [{_, _} | t]) do
    lookup(id, t)
  end

  def remove(_, []) do [] end
  def remove([], env) do env end
  def remove([idH | idT], [envH | envT]) do
    if(envH == idH) do
      remove(idT, remove([idH | idT], envT))
    else
      remove(idT, [envH | remove([idH | idT], envT)])
    end
  end

end
