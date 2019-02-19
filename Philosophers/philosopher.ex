defmodule Philosopher do

  def start(hunger, right, left, name, ctrl) do
    spawn_link(fn -> dreaming(hunger, right, left, name, ctrl) end)
  end

  def dreaming(hunger, right, left, name, ctrl) do
    IO.puts("#{name} is dreaming...")
    sleep(1000)
    waiting(hunger, right, left, name, ctrl)
  end

  def waiting(hunger, right, left, name, ctrl) do
    IO.puts("#{name} is waiting for the left chopstick...")
    case Chopstick.request(left, 10000) do
      :failed ->
        IO.puts("#{name} gave up trying to pick up the left chopstick")
        dreaming(hunger, right, left, name, ctrl)
      :ok ->
        IO.puts("#{name} picked up the left chopstick")
        sleep(1000)
        IO.puts("#{name} is waiting for the right chopstick...")
        case Chopstick.request(right, 10000) do
          :failed ->
            IO.puts("#{name} gave up trying to pick up the right chopstick")
            dreaming(hunger, right, left, name, ctrl)
          :ok ->
            IO.puts("#{name} picked up the right chopstick")
            eating(hunger, right, left, name, ctrl)
        end
    end
  end

  def eating(0, right, left, name, ctrl) do
    Chopstick.return(left)
    Chopstick.return(right)
    IO.puts("#{name} is done")
    send(ctrl, :done)

  end
  def eating(hunger, right, left, name, ctrl) do
    IO.puts("#{name} is eating...")
    Chopstick.return(left)
    Chopstick.return(right)
    dreaming(hunger-1, right, left, name, ctrl)
  end

  def sleep(0) do :ok end
  def sleep(t) do
    :timer.sleep(:rand.uniform(t))
  end
end
