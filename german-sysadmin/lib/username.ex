defmodule Username do
  def sanitize(~c''), do: ~c''

  def sanitize([head | tail]) do
    sanitized_chars =
      case head do
        head when head >= ?a and head <= ?z -> [head]
        ?_ -> [?_]
        ?ä -> [?a, ?e]
        ?ö -> [?o, ?e]
        ?ü -> [?u, ?e]
        ?ß -> [?s, ?s]
        _ -> []
      end

    sanitized_chars ++ sanitize(tail)
  end
end
