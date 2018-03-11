defmodule Xpar.TeamsControllerTest do
  use XparWeb.ConnCase
  alias Xpar.Team

  test "should return 204 for team creation", %{conn: conn} do
    id = "ichigo"
    team = %{id: id, repos: ["pairing-demo1", "pairing-demo2"]}

    response =
      conn
      |> post("/api/teams/#{id}/repos", team)

    assert response.status == 204
  end

  test "should persist team info across calls", %{conn: conn} do
    id = "ichigo"
    team = %{"id" =>  id, "repos" => ["pairing-demo1", "pairing-demo2"]}

    conn |> post("/api/teams/#{id}/repos", team)

      response = conn
      |> get("/api/teams/#{id}/repos")
      |> json_response(200)

     assert response == team
  end

end
