defmodule Xpar.Pairing.Pair do
  alias Xpar.Pairing.Stats

  defstruct [first: nil, second: nil, timestamp: nil]

  def new([head | []], timestamp) do
    %Xpar.Pairing.Pair{first: head, second: head, timestamp: timestamp}
  end

  def new([], _)  do
    nil
  end

  def new([head | [first | second]], timestamp)  do
    %Xpar.Pairing.Pair{first: String.downcase(head), second: String.downcase(first), timestamp: timestamp}
  end
end
