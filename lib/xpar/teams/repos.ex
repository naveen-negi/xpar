defmodule Xpar.Teams.Repos do
  defstruct [id: nil, repos: []]

  def new(id) do
    %Xpar.Teams.Repos{id: id, repos: []}
  end

  def add(team, repos) do
    %Xpar.Teams.Repos{team | repos: repos}
  end
end
