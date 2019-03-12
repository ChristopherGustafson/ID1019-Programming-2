defmodule AVL do

  def insert(tree, key, value) do
    case insrt(tree, key, value) do
      {:inc, q} -> q
      {:ok, q} ->
    end
  end

  defp insrt(nil, key, value) do
    {:inc, {:node, key, value, 0, nil, nil}}
  end

  defp insrt({:node, key, _, f, a, b}, key, value) do
    {:ok, {:node, key, value, f, a, b}}
  end

  defp insrt({:node, rk, rv, 0, a, b}, kk, kv) when kk < rk do
    
  end
end
