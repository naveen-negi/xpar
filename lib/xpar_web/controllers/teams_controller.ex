defmodule XparWeb.TeamsController do
  use XparWeb, :controller
  alias Xpar.Teams
  alias Xpar.Teams.{ Repos, Members }

  def create_repos(conn, %{"id" =>  id, "repos" =>  repos} = _params) do
    Repos.new(id)
    |> Repos.add(repos)
    |> Teams.add_repos

     conn
     |> put_status(204)
     |> json("done")
  end

  def create_members(conn, %{"id" =>  id, "members" =>  members} = _params) do
    Members.new(id)
    |> Members.add(members)
    |> Teams.add_members

    conn
    |> put_status(204)
    |> json("done")
  end

  def get_repos(conn, _params) do
    id = conn.params["id"]
    team = Teams.get_repos(id)

    conn
    |> put_resp_content_type("application/json")
    |> put_status(200)
    |> json(team)
  end

  def get_members(conn, _params) do
    id = conn.params["id"]
    members = Teams.get_members(id)
    conn
    |> put_resp_content_type("application/json")
    |> put_status(200)
    |> json(members)
  end
end
