defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  def display_distance(remote_car) when remote_car.__struct__ == RemoteControlCar do
    %{distance_driven_in_meters: distance, battery_percentage: _, nickname: _} = remote_car
    "#{distance} meters"
  end

  def display_battery(remote_car) when remote_car.__struct__ == RemoteControlCar do
    %{distance_driven_in_meters: _, battery_percentage: battery, nickname: _} = remote_car

    cond do
      battery == 0 -> "Battery empty"
      true -> "Battery at #{battery}%"
    end
  end

  def drive(remote_car)
      when remote_car.battery_percentage > 0 and remote_car.__struct__ == RemoteControlCar do
    %{distance_driven_in_meters: distance, battery_percentage: battery, nickname: _} = remote_car
    %{remote_car | distance_driven_in_meters: distance + 20, battery_percentage: battery - 1}
  end

  def drive(remote_car) when remote_car.__struct__ == RemoteControlCar, do: remote_car
end
