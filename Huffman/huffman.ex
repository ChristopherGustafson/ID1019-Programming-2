defmodule Huffman do

  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text() do
    'this is something that we should encode'
  end

  def test do
    sample = sample()
    tree = tree(sample)
    """
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
    """
  end

  # Create a Huffman tree given a sample text
  def tree(sample) do
    freq = freq(sample)
  end

  def freq(sample) do freq(sample, []) end
  def freq([], freq) do freq end
  def freq([char | rest], freq) do

    if(counted(char, freq) == :true) do
      freq(rest, freq)
    else
      freq(rest, freq ++ [freq(char, rest, 1)])
    end
  end

  def freq(char, [], count) do
    {char, count}
  end
  def freq(char, [h | t], count)  do
    if(char == h) do
      freq(char, t, count+1)
    else
      freq(char, t, count)
    end
  end

  def counted(char, []) do :false end
  def counted(char, [h | t]) do
    if ({char, _} = h) do
      :true
    else
      counted(char, t)
    end
  end


  # Create an encoding table containing the mapping from
  # characters to codes given a Huffman tree.
  def encode_table(tree) do

  end

  # Create an decoding table containing the mapping from
  # codes to characters given a Huffman tree
  def decode_table(tree) do

  end

  # Encode the text using the mapping in the table
  def encode(text, table) do

  end

  # Decode the bit squence using the mapping in the table
  def decode(seq, table) do

  end
end
