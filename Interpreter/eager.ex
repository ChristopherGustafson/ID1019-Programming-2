defmodule Eager do


  # Evaluate an expression, return {:ok, data strucutre} or :error
  def eval_expr({:atm, id}, _) do
    {:ok, id}
  end

  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil ->
        :error
      {_, str} ->
        {:ok, str}
    end
  end

  def eval_expr({:cons, a, b}, env) do
    case eval_expr(a, env) do
      :error ->
        :error
      {:ok, str} ->
        case eval_expr(b, env) do
          :error ->
            :error
          {:ok, ts} ->
            {:ok, [str | ts]}
        end
    end
  end

  def eval_expr({:case, expr, cls}, env) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, str} ->
        eval_cls(cls, str, env)
    end
  end

  def eval_expr({:lambda, par, free, seq}, env) do
    case Env.closure
  end

  # Evaluate a given a data structure against a list of clauses
  def eval_cls([], _, _) do :error end
  def eval_cls([{:clause, ptr, seq} | cls], str, env) do
    vars = extract_vars(ptr)
    env = Env.remove(vars, env)
    case eval_match(ptr, str, env) do
      :fail ->
        eval_cls(cls, str, env)
      {:ok, env} ->
        eval_seq(seq, env)
    end
  end

  # Evaluate a pattern match, return {:ok, updated environment} or :fail
  def eval_match(:ignore, _, env) do
    {:ok, env}
  end
  def eval_match({:atm, _}, _, env) do
    {:ok, env}
  end
  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil ->
        {:ok, Env.add(id, str, env)}
      {_, ^str} ->
        {:ok, env}
      {_, _} ->
        :fail
    end
  end
  def eval_match({:cons, hp, tp}, [hs | ts], env) do
    case eval_match(hp, hs, env) do
      :fail ->
        :fail
      {:ok, env} ->
        eval_match(tp, ts, env)
    end
  end
  def eval_match(_, _, _) do
    :fail
  end

  # Evalute a given sequence
  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end
  def eval_seq([{:match, pattern, expression} | seqTail], env) do
    case eval_expr(expression, env) do
      :error ->
        :error
      {:ok, str} ->
        vars = extract_vars(pattern)
        env = Env.remove(vars, env)

        case eval_match(pattern, str, env) do
          :fail ->

            :error
          {:ok, env} ->
            eval_seq(seqTail, env)
        end
    end
  end

  # Retrun a list of all variables in a pattern
  def extract_vars(pattern) do
    case pattern do
      {:var, id} ->
        [{:var, id}]
      {:cons, p1, p2} ->
        extract_vars(p1) ++ extract_vars(p2)
      _ ->
        []
    end
  end

  # Evaluate a given sequence
  def eval(seq) do
    eval_seq(seq, [])
  end

end
