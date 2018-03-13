defmodule Xpar.Pairing.Matrix do
  alias Xpar.Pairing.Pair

  defstruct [pairs: nil]

  def new  do
    %Xpar.Pairing.Matrix{pairs: []}
  end

  def add_pair(matrix, pairs) do
    %Xpar.Pairing.Matrix{matrix | pairs: [pairs | matrix.pairs]}
  end

  defp process_pairs(pairs) do
  end
end
