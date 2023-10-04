defmodule BirdCount do
  def today([]), do: nil
  def today([head | _tail]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  def has_day_without_birds?(list), do: 0 in list

  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)

  def busy_days(list, days_num \\ 0)
  def busy_days([], days_num), do: days_num
  def busy_days([head | tail], days_num) do
    cond do
      head >= 5 -> busy_days(tail, days_num + 1)
      true -> busy_days(tail, days_num)
    end
  end
end
