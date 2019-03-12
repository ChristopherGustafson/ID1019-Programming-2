defmodule TwoThree do

  def test do
    insertf(14, :grk, {:two, 7, {:three, 2, 5, {:leaf, 2, :foo},
    {:leaf, 5, :bar}, {:leaf, 7, :zot}}, {:three, 13, 16,
    {:leaf, 13, :foo}, {:leaf, 16, :bar}, {:leaf, 18, :zot}}})
  end

  # Insert key-value pair into empty tree
  def insertf(key, value, nil), do: {:leaf, key, value}

  # Insert key-value pair into a leaf
  def insertf(key, value, {:leaf, key1, _} = l) do
    cond do
      key <= key1 ->
        {:two, key, {:leaf, key, value}, l}
      true ->
        {:two, key1, l, {:leaf, key, value}}
    end
  end

  # Insert key-value pair into a two-node containging leafs
  def insertf(key, value, {:two, key1, {:leaf, key1, _} = l1, {:leaf, key2, _} = l2}) do
    cond do
      key <= key1 ->
        {:three, key, key1, {:leaf, key, value}, l1, l2}
      key <= key2 ->
        {:three, key1, key, l1, {:leaf, key, value}, l2}
      true ->
        {:three, key1, key2, l1, l2, {:leaf, key, value}}
    end
  end

  # Insert a key-value pair into a three-node containgin leafs
  def insertf(key, value, {:three, key1, key2, {:leaf, key1, _} = l1, {:leaf, key2, _} = l2, {:leaf, key3, _} = l3}) do
    cond do
      key <= key1 ->
        {:four, key, key1, key2, {:leaf, key, value}, l1, l2, l3}
      key <= key2 ->
        {:four, key1, key, key2, l1, {:leaf, key, value}, l2, l3}
      key <= key3 ->
        {:four, key1, key2, key, l1, l2, {:leaf, key, value}, l3}
      true ->
        {:four, key1, key2, key3, l1, l2, l3, {:leaf, key, value}}
    end
  end

  # Insert a key-value pair into an internal two-node
  def insertf(key, value, {:two, key1, left, right}) do
    cond do
      key <= key1 ->
        case insertf(key, value, left) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:three, q2, key1, {:two, q1, t1, t2}, {:two, q3, t3, t4}, right}
          updated ->
            {:two, key1, updated, right}
        end
      true ->
        case insertf(key, value, right) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:three, q2, key1, left, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
          updated ->
            {:two, key1, left, updated}
        end
    end
  end

  def insertf(key, value, {:three, key1, key2, left, middle, right}) do
    cond do
      key <= key1 ->
        case insertf(key, value, left) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:four, q2, key1, key2, {:two, q1, t1, t2}, {:two, q3, t3, t4}, middle, right}
          updated ->
            {:three, key1, key2, updated, middle, right}
        end
      key <= key2 ->
        case insertf(key, value, middle) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:four, key1, q2, key2, left, {:two, q1, t1, t2}, {:two, q3, t3, t4}, right}
          updated ->
            {:three, key1, key2, left, updated, right}
        end
      true ->
        case insertf(key, value, right) do
          {:four, q1, q2, q3, t1, t2, t3, t4} ->
            {:four, key1, key2, q2, left, middle, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
          updated ->
            {:three, key1, key2, left, middle, updated}
        end
    end
  end

  def insert(key, value, root) do
    case insertf(key, value, root) do
      {:four, q1, q2, q3, t1, t2, t3, t4} ->
        {:two, q2, {:two, q1, t1, t2}, {:two, q3, t3, t4}}
      updated ->
        updated
    end
  end
end
