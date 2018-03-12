defmodule Xpar.Services.PairMatrixServiceTest do
  use ExUnit.Case, aysnc: false
  import Mock
  alias Xpar.Services.PairingMatrixService
  alias Xpar.Teams.Team
  alias Xpar.Teams
  alias Xpar.Pairing.{ Matrix, Pair }
  alias Xpar.Client.BitBucket

  test "should return pairing matrix" do
    with_mocks([{BitBucket,[], [get_commit_messages: fn (id, repo) -> [{:ok, "naveen1/naveen2 - fake commit"} ] end] }, {Teams, [],[get: fn id -> [ "naveen1", "naveen2"  ] end]}]) do
      id = "team-1"

      expected =
        Matrix.new
      |> Matrix.add_pair(%Pair{first: "naveen1", second: "naveen2"})

      matrix = PairingMatrixService.get_pairing_matrix(id)
      IO.inspect matrix
      assert matrix == expected
    end
  end
end
