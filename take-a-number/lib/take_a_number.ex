defmodule TakeANumber do
  defp machine_fn()

  defp machine_fn(state \\ 0) do
    receive do
      {:report_state, sender_id} ->
        send(sender_id, state)
        machine_fn(state)

      {:take_a_number, sender_id} ->
        send(sender_id, state + 1)
        machine_fn(state + 1)

      :stop ->
        :stop

      _ ->
        machine_fn(state)
    end
  end

  def start() do
    spawn(&machine_fn/0)
  end
end
