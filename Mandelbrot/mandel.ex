defmodule Mandel do


  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
      Cmplx.new(x + k * (w - 1), y - k * (h-1))
    end
    rows(width, height, trans, depth, [])
  end

  def rows(width, 0, trans, depth, rows) do
    rows
  end
  def rows(width, height, trans, depth, rows) do
    row = row(width, height, trans, depth, [])
    rows(width, height-1, trans, depth, [row | rows])
  end

  def row(0, height, trans, depth, row) do
    row
  end
  def row(width, height, trans, depth, row) do
    c = trans.(width, height)
    d = Brot.mandelbrot(c, depth)
    color = Color.convert(d, depth)
    row(width-1, height, trans, depth, [color | row])
  end



end
