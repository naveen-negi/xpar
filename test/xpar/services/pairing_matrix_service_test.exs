defmodule Xpar.Services.PairMatrixServiceTest do
  use ExUnit.Case, aysnc: false
  import Mock
  alias Xpar.Services.PairingMatrixService
  alias Xpar.Teams
  alias Xpar.Teams.{ Repos, Members}
  alias Xpar.Pairing.{ Matrix, Pair }
  alias Xpar.Client.BitBucket

  test "should return pairing matrix" do
    with_mocks([{ BitBucket,
                 [],
                  [get_commit_messages: fn (id, repo) -> [{:ok, "naveen1/naveen2 - fake commit"},{:ok, "naveen1/naveen2 - fake commit 2"}  ] end]
                },
                {
                  Teams, [],[get_repos: fn id -> %Repos{id: id, repos: ["paring-demo-1", "paring-demo-2"] } end]
                },
                {
                  Teams, [],[get_members: fn id -> %Members{id: id, members: [ "naveen1", "naveen2"  ] } end]
                }
               ]) do
      id = "team-1"

      expected =
        Matrix.new
      |> Matrix.add_pair(%Pair{first: "naveen1", second: "naveen2"})
      |> Matrix.add_pair(%Pair{first: "naveen1", second: "naveen2"})
      |> Matrix.add_pair(%Pair{first: "naveen1", second: "naveen2"})
      |> Matrix.add_pair(%Pair{first: "naveen1", second: "naveen2"})

      matrix = PairingMatrixService.get_pairing_matrix(id)
      IO.inspect matrix
      assert matrix == Matrix.process_pairs(expected)
    end
  end
end
