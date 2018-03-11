defmodule XparWeb.TeamsController do
  use XparWeb, :controller
  alias Xpar.Teams
  alias Xpar.Teams.Team

  def create(conn, %{"id" =>  id, "repos" =>  repos} = params) do
      Team.new(id)
      |> Team.add_repos(repos)
      |> Teams.save

     conn
     |> put_status(204)
     |> json("done")
  end

  def get(conn, _params) do
    id = conn.params["id"]
    [head | tail] = Teams.get(id)
    team = elem(head, 1)

    conn
    |> put_resp_content_type("application/json")
    |> put_status(200)
    |> json(team)
  end
end
