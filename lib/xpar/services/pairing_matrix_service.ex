defmodule Xpar.Services.PairingMatrixService do
  alias Xpar.Client.BitBucket
  alias Xpar.Server.TeamServer
  alias Xpar.Pairing.{ Pair, Matrix }
  alias Xpar.Teams.{Repos, Members}

  @team_server  Xpar.Teams
  @bitbucket_client Xpar.Client.BitBucket

  def get_pairing_matrix(id) do
  %Repos{id: id, repos: repos} = @team_server.get_repos(id)
  %Members{id: _, members: members} = @team_server.get_members(id)

  pairs =
    repos
    |> Enum.map(fn repo ->  get_pairing_matrix_for(id, repo, members) end)
    |> Enum.reduce(Matrix.new, fn (pair, acc) -> Matrix.add_pair(acc, pair) end)

  end

  defp get_pairing_matrix_for(id, repo, members) do
    @bitbucket_client.get_commit_messages(id, repo)
    |> Enum.map(fn message -> get_pair(message, members) end)
    |> Enum.filter(fn pair -> !is_nil(pair) end)
  end

  defp get_pair({:ok, commit_message}, members) do
    String.split(commit_message, [" ", "/"])
    |> Enum.filter(&Enum.member?(members, &1))
    |> Pair.new
  end

end
