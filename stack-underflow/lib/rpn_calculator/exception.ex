defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    def exception(term) do
      case term do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: " <> term}
      end
    end
  end

  def divide([]), do: raise(StackUnderflowError, "when dividing")
  def divide([_]), do: raise(StackUnderflowError, "when dividing")
  def divide([0 | _]), do: raise(DivisionByZeroError)

  def divide([divisor | [dividend | _]]) do
    dividend / divisor
  end
end
