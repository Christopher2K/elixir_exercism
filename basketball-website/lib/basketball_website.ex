defmodule BasketballWebsite do
  def extract_from_path(nil, _), do: nil
  def extract_from_path(data, ""), do: data

  def extract_from_path(data, path) do
    [key | tail] = path |> String.split(".")
    extract_from_path(data[key], Enum.join(tail, "."))
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, path |> String.split("."))
  end
end
