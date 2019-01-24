defmodule Derivative do

  @type literal() ::
  {:const, number()}
  | {:const, atom()}
  | {:var, atom()}

  @type expr() ::
  {:add, expr(), expr()}
  | {:mul, expr(), expr()}
  | {:exp, expr(), expr()}
  | {:ln, expr()}
  | {:sqrt, expr()}
  | {:sin, expr()}
  | {:cos, expr()}
  | literal()

  #Derivate a constant
  def deriv({:const, _}) do 0 end
  #Derivate a single variable
  def deriv({:var, _}) do 1 end
  #Derivate a multiplikation of two expressions
  def deriv({:mul, e1, e2}) do
    {:add, {:mul, deriv(e1), e2}, {:mul, e1, deriv(e2)}}
  end
  #Derivate an addition of two expressions
  def deriv({:add, e1, e2}) do
    {:add, deriv(e1), deriv(e2)}
  end

  #Derivative of exponential x^n
  def deriv({:exp, x, n}) do
    {:mul, n, {:exp, x, {:add, n, {:const, -1}}}}
  end

  #Derivative of ln(x)
  def deriv({:ln, x}) do
    {:exp,{:mul, x, deriv(x)}, {:const, -1}}
  end

  #Derivative of sin(x)
  def deriv({:sin, x}) do
    {:mul, deriv(x), {:cos, x}}
  end

  def deriv({:sqrt, x}) do
    evaluate({:mul, {:exp, {:sqrt, x}, {:const, -1}}, {:const, -1}})
  end


  def evaluate({:const, c}) do c end
  def evaluate({:var, x}) do x end

  def evaluate({:mul, {:const, 0}, _}) do 0 end
  def evaluate({:mul, _, {:const, 0}}) do 0 end
  def evaluate({:mul, e1, e2}) do
    {:mul, evaluate(e1), evaluate(e2)}
  end
  def evaluate({:add, e1, e2}) do
    {:add, evaluate(e1), evaluate(e2)}
  end
  def evaluate(e) do e end
end
