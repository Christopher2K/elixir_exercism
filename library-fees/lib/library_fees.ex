defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime) do
    datetime |> NaiveDateTime.to_time() |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    checkout_datetime |> NaiveDateTime.to_date() |> Date.add(days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    if Date.compare(planned_return_date, NaiveDateTime.to_date(actual_return_datetime)) == :gt do
      0
    else
      actual_return_datetime |> NaiveDateTime.to_date() |> Date.diff(planned_return_date)
    end
  end

  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = checkout |> datetime_from_string()
    return_datetime = return |> datetime_from_string()
    planned_return_date = checkout_datetime |> return_date()
    days_late = days_late(planned_return_date, return_datetime)

    cond do
      days_late == 0 -> 0
      days_late == 1 -> rate
      monday?(return_datetime) -> trunc(days_late * rate / 2)
      true -> days_late * rate
    end
  end
end
