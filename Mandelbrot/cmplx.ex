defmodule Cmplx do

  # Return representation of the complex number r+i(i)
  def new(r, i) do
    {r, i}
  end

  # Add two complex numbers
  def add({r1, i1}, {r2, i2}) do
    {r1+r2, i1+i2}
  end

  # Square a complex number
  def sqr({r, i}) do
    {(r*r)-(i*i), 2*r*i}
  end

  # Return the absolute value of
  def abs({r, i}) do
    :math.sqrt(r*r+i*i)
  end

end
