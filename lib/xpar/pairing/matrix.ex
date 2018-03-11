defmodule Xpar.Pairing.Matrix do
  alias Xpar.Pairing.Pair

  defstruct [pairs: nil]

  def new  do
    %Xpar.Pairing.Matrix{pairs: []}
  end

  def add_pair(matrix, pair) do
    %Xpar.Pairing.Matrix{matrix | pairs: [pair | matrix.pairs]}
  end
end
