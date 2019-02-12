
defmodule Test do

  def double(n) do
    n*2
  end

  def toCelsius(f) do
    (f-32)/1.8
  end

  def areaRect(l,b) do
    l*b
  end

  def areaSquare(s) do
    areaRect(s,s)
  end

  def product_clauses(0,_) do 0 end
  def product_clauses(m,n) do
    product_clauses(m-1,n) + n
  end

  def exp(x, n) do
    case n do
      0 -> 1
      _ -> product_clauses(x,exp(x, n-1))
    end
  end

  def exp2_clauses(x, 0) do 1 end
  def exp2_clauses(x, 1) do x end
  def exp2_clauses(x, n) do
    if rem(n,2) == 0 do
      exp2_clauses(x,div(n,2))*exp2_clauses(x,div(n,2))
    else
      exp2_clauses(x,(n-1))*x
    end
  end
end
