defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_, volume} = volume_pair
    volume
  end

  def to_milliliter(volume_pair) do
    {volume_unit, volume} = volume_pair

    converted_volume =
      cond do
        volume_unit == :cup -> volume * 240.0
        volume_unit == :fluid_ounce -> volume * 30.0
        volume_unit == :teaspoon -> volume * 5.0
        volume_unit == :tablespoon -> volume * 15.0
        volume_unit == :milliliter -> volume * 1.0
      end

    {:milliliter, converted_volume}
  end

  def from_milliliter(volume_pair, unit) do
    volume = get_volume(volume_pair)

    converted_volume =
      cond do
        unit == :cup -> volume / 240.0
        unit == :fluid_ounce -> volume / 30.0
        unit == :teaspoon -> volume / 5.0
        unit == :tablespoon -> volume / 15.0
        unit == :milliliter -> volume / 1.0
      end

    {unit, converted_volume}
  end

  def convert(volume_pair, unit) do
    volume_pair |> to_milliliter() |> from_milliliter(unit)
  end
end
