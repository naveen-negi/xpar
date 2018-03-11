defmodule Xpar.Teams.Team do
  defstruct [id: nil, repos: []]

  def new(id) do
    %Xpar.Teams.Team{id: id, repos: []}
  end

  def add_repos(team, repos) do
    %Xpar.Teams.Team{team | repos: repos}
  end
end
