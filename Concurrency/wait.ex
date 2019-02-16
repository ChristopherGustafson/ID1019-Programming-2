defmodule Wait do

  def hello do
    receive do
      x -> IO.puts("aaa! suprise, a message: #{x}")
    end
  end
end
