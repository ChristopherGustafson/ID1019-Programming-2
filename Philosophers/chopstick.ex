defmodule Chopstick do

  def start do
    stick = spawn_link(fn -> available() end)
  end

  def available() do
    receive do
      {:request, from} ->
        send(from, :granted)
        gone()

      {:request, ref, from} ->
        send(from, {:granted, ref})
        gone(ref)

      :quit -> :ok
    end
  end

  def gone() do
    receive do
      :return -> available()
      :quit -> :ok
    end
  end

  def gone(ref) do
    receive do
      {:return, ^ref} ->
        available()

      :quit ->
        :ok
    end
  end

  def request(stick) do
    send(stick, {:request, self()})
    receive do
      :granted -> :ok
    end
  end

  def request(stick, timeout) do
    send(stick, {:request, self()})
    receive do
      :granted -> :ok
    after
      timeout -> :failed
    end
  end


  def request(stick, ref, timeout) do
    send(stick, {:request, ref, self()})
    wait(ref, timeout)
  end

  def wait(ref, timeout) do
    receive do
      {:granted, ^ref} ->
        :ok

      {:granted, _} ->
        wait(ref, timeout)

      after
        timeout -> :failed
    end
  end

  def return(stick) do
    send(stick, :return)
  end

  def terminate(stick) do
    send(stick, :quit)
  end
end
