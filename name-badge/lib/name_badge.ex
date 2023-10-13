defmodule NameBadge do
  def print(id, name, department) do
    id_string = if id, do: "[#{id}] - ", else: ""
    dpt_string = if department, do: department |> String.upcase(), else: "OWNER"

    "#{id_string}#{name} - #{dpt_string}"
  end
end
