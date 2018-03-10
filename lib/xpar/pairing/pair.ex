defmodule Xpar.Pairing.Pair do
  defstruct [first: nil, second: nil]

  def new([head | tail])  do
    %Xpar.Pairing.Pair{first: head, second: tail}
  end

  def new([])  do
    nil
  end
end
