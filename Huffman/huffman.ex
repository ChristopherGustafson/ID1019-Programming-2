defmodule Huffman do

  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def sample2 do
    'abcaba'
  end

  def text() do
    'this is something that we should encode'
  end

  def test() do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = encode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)

  end

  # Create a Huffman tree given a sample text
  def tree(sample) do
    freq = freq(sample)
    huffman(freq)
  end

  # Find the frequency of the characters in the sample text
  def freq(sample) do freq(sample, []) end
  def freq([], freq) do freq end
  def freq([char | rest], freq) do
    freq(rest, count(char, freq))
  end

  # Count how many occurences of a character char
  def count(char, []) do [{char, 1}] end
  def count(char, [{char, n} | rest]) do
    [{char, n+1} | rest]
  end
  def count(char, [head | tail]) do
    [head | count(char, tail)]
  end

  # Given a list of character frequencies, build a Huffman tree
  def huffman(freq) do
    sorted = sort(freq, [])
    build_tree(sorted)
  end

  # Sort a given list
  def sort([], l) do l end
  def sort([h1 | t1], l) do
    sort(t1, insert(h1, l))
  end

  # Insert an element e into the right place in a list
  def insert(e, []) do [e] end
  def insert({c1, f1}, [{c2, f2} | tail]) do
    if(f1 < f2) do
      [{c1, f1}, {c2, f2} | tail]
    else
      [{c2, f2} | insert({c1, f1}, tail)]
    end
  end

  # Given a sorted list, build a huffman tree
  def build_tree([]) do [] end
  def build_tree([e]) do e end
  def build_tree([{c1, f1}, {c2, f2} | tail]) do
    build_tree(insert({{c1, c2}, f1+f2}, tail))
  end

  # Create an encoding table containing the mapping from
  # characters to codes given a Huffman tree.
  def encode_table({tree, _}) do
    dive(tree, [])
  end

  def dive({left, right}, seq) do
    lt = dive(left, [0 | seq])
    rt = dive(right, [1 | seq])
    lt ++ rt
  end
  def dive(leaf, seq) do
    [{[leaf], Enum.reverse(seq)}]
  end

  # Encode the text using the mapping in the table
  def encode([], table) do [] end
  def encode([head | tail], table) do
    enc(head, table) ++ encode(tail, table)
  end

  def enc(symbol, []) do [] end
  def enc(symbol, [{char, code} | tail]) do
    if([symbol] == char) do
      code
    else
      enc(symbol, tail)
    end
  end

  # Decode the bit squence using the mapping in the table
  def decode([], _) do [] end
  def decode(seq, table) do
    {char, rest} = decode_char(seq, 1, table)
    [char | decode(rest, table)]
  end

  def decode_char(seq, n, table) do
    {code, rest} = Enum.split(seq, n)

    case List.keyfind(table, code, 1) do
      {a, _} ->
        {a, rest}
      nil ->
        decode_char(seq, n+1, table)
    end
  end
end
