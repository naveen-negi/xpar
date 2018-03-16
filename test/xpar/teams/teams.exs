defmodule Xpar.Teams.TeamsTest do
  use  ExUnit.Case
  alias Xpar.Teams
  alias Xpar.Teams.Team

  test "should persist team" do
    id = "team-1"
    expected_team =
    Team.new(id)
    |> Team.add_repos(["repo-1", "repo-2"])

    Teams.save(expected_team)

    actual_team = Teams.get(id)
    assert expected_team =  actual_team
  end

end
