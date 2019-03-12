defmodule Semaphore do

def semaphore(0) do
  receive do
    :release ->
      semaphore(1)
  end
end

def semaphore(n) do
  receive do
    {:request, , ref, from} ->
      send(from, {:granted, ref})
      semaphore(n-1)
    :release ->
      semaphore(n+1)
  end
end

def semaphore(n, l) do
  case n do
    0 ->
      receive do
        {:request, from} ->
          semaphore(0, l ++ [from])
        :release ->
          semaphore(1, l)
      end
    _ ->
      receive do
        {:request, from} ->
          case l do
            [] ->
              send(from, :granted)
              semaphore(n-1, l)
            [head | tail] ->
              send(head, :granted)
              semaphore(n-1, tail)
          end
        :release ->
          semaphore(n+1, l)
      end
  end
end

def request(semaphore) do
  send(semaphore, {:request, self()})
  receive do
    :granted ->
      :ok
  after
    1000 ->
      :abort
  end
end

def refrequest(semaphore) do
  ref = make_ref()
  send(semaphore, {:request, ref, self()})
  wait(semaphore, ref)
end

def wait(semaphore, ref) do
  receive do
    {:granted, ^ref} ->
      :ok
    {:granted, _} ->
      wait(semaphore, ref)
  after
    1000 ->
      send(semaphore, :release)
      :abort
  end
end


end
