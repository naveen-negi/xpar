defmodule Xpar.Pairing.Pair do
  alias Xpar.Pairing.Stats

  defstruct [first: nil, second: nil]

  def new([head | []]) do
    %Xpar.Pairing.Pair{first: head, second: nil}
  end

  def new([])  do
    nil
  end

  def new([head | [first | second]])  do
    %Xpar.Pairing.Pair{first: head, second: first}
  end
end
