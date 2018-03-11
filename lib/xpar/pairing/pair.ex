defmodule Xpar.Pairing.Pair do
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
