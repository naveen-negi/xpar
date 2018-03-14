defmodule Xpar.Paring.MatrixTest do
  use ExUnit.Case
  alias Xpar.Pairing.{Matrix, Pair, Stats }

  test "should calulate total number of days paired" do
    pair_1 = %Pair{first: "a", second: "b"}
    pair_2 = %Pair{first: "a", second: "b"}
    pair_3 = %Pair{first: "c", second: "d"}
    pair_4 = %Pair{first: "c", second: "d"}

    matrix =
      Matrix.new
      |> Matrix.add_pair(pair_1)
      |> Matrix.add_pair(pair_2)
      |> Matrix.add_pair(pair_3)
      |> Matrix.add_pair(pair_4)

    stats = Matrix.process_pairs(matrix)

    assert length(stats) == 2

    stats
      |> Enum.each(fn stat ->
      assert stat.days_paired == 2
      assert stat.percent == 50 
      end)
  end

  defp get_matrix do
  end
end
