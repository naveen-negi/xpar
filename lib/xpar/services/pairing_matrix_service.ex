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
  matrix_new = Matrix.new
  matrix =
    repos
    |> Enum.flat_map(fn repo ->  get_pairs_for(id, repo, members) end)
    |> Enum.reduce(matrix_new, fn (pair, acc) -> Matrix.add_pair(acc, pair) end)
    Matrix.process_pairs(matrix)
  end

  defp get_pairs_for(id, repo, members) do
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
