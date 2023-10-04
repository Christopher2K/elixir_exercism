defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: 8.0 * hourly_rate

  def apply_discount(before_discount, discount), do: before_discount * ((100 - discount) / 100)

  def monthly_rate(hourly_rate, discount),
    do:
      hourly_rate
      |> daily_rate()
      |> apply_discount(discount)
      |> Kernel.*(22.0)
      |> Float.ceil(0)
      |> Kernel.trunc()

  def days_in_budget(budget, hourly_rate, discount) do
    rate = hourly_rate |> daily_rate() |> apply_discount(discount)
    (budget / rate) |> Float.floor(1)
  end
end
