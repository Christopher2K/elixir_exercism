defmodule TopSecret do
  def to_ast(string) do
    case Code.string_to_quoted(string) do
      {:ok, ast} -> ast
      _ -> nil
    end
  end

  def decode_secret_message_part({op, _, _} = ast, acc) when op not in [:def, :defp],
    do: {ast, acc}

  def decode_secret_message_part({op, _, [{_, _, nil} | _]} = ast, acc) when op in [:def, :defp],
    do: {ast, ["" | acc]}

  def decode_secret_message_part(
        {op, _, [{:when, _, [{function_name, _, args} | _]} | _]} = ast,
        acc
      )
      when op in [:def, :defp] do
    {fn_name, _} = Atom.to_string(function_name) |> String.split_at(length(args))
    {ast, [fn_name | acc]}
  end

  def decode_secret_message_part({op, _, [{function_name, _, args} | _]} = ast, acc)
      when op in [:def, :defp] do
    {fn_name, _} = Atom.to_string(function_name) |> String.split_at(length(args))
    {ast, [fn_name | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    ast = Code.string_to_quoted(string)

    {_, acc} =
      Macro.traverse(
        ast,
        [],
        fn node, acc ->
          decode_secret_message_part(node, acc)
        end,
        fn node, acc ->
          {node, acc}
        end
      )

    acc |> Enum.reverse() |> Enum.join("")
  end
end
