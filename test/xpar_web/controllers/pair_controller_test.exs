defmodule XparWeb.PairControllerTest do
  import Mock
  use XparWeb.ConnCase
  alias Xpar.Client.BitBucket

  test "should get pairing-matrux", %{conn: conn} do
    with_mock BitBucket, [get_commit_messages: fn (id, repo) -> get_mocked_messages()  end] do
    id = "knav"
    members = %{id: id, members: ["naveen1", "naveen2"]}
    repos = %{id: id, repos: ["pairing-demo"]}

    id = "team-2"
    conn = post conn, "api/teams/#{id}/members", members
    conn = post conn, "api/teams/#{id}/repos", repos

    conn = get conn, "api/teams/#{id}/pairing-matrix"
    response =
    conn
    |> get("api/teams/#{id}/pairing-matrix")
    |> json_response(200)
    assert !is_nil(response)
    end
  end

  def get_mocked_messages do
    [{:ok, "naveen2/naveen1 fake commt 1" },{:ok, "naveen2/naveen1 fake commt 2" }]
  end

end
