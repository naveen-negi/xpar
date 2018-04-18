defmodule Xpar.Services.PairingMatrixService do
  alias Xpar.Client.BitBucket
  alias Xpar.Server.TeamServer
  alias Xpar.Pairing.{ Pair, Matrix }
  alias Xpar.Teams.{Repos, Members}
  alias Xpar.Teams

  @team_server  Xpar.Teams
  @bitbucket_client Xpar.Client.BitBucket

  def get_pairing_matrix(id) do
  # %Repos{id: id, repos: repos} = @team_server.get_repos(id)
    repos =
    id
    |> @bitbucket_client.get_all_projects_for
    |> Enum.map(fn result -> result.repo_name end)

  %Members{id: _, members: members} = @team_server.get_members(id)
  Teams.add_repos(%Repos{id: id, repos: repos} )

  # matrix_new = Matrix.new
  # matrix =
  #   repos
  #   |> Enum.flat_map(fn repo ->  get_pairs_for(id, repo, members) end)
  #   |> Enum.reduce(matrix_new, fn (pair, acc) -> Matrix.add_pair(acc, pair) end)

  #    Matrix.process_pairs(matrix)

  result =
  repos
  |> Enum.map(&Task.async(fn -> get_pairs_for(id, &1, members) end))
  |> Enum.flat_map(&Task.await/1)
  
  IO.inspect result

    matrix =
      result
      |> Enum.reduce(Matrix.new, fn (pair, acc) -> Matrix.add_pair(acc, pair) end)

    IO.inspect matrix
    Matrix.process_pairs(matrix)

  end

  defp get_pairs_for(id, repo, members) do
    @bitbucket_client.get_commit_messages(id, repo)
    |> Enum.filter(fn value -> !String.contains?(value.message, "pull request") end)
    |> Enum.map(fn value -> get_pair(value.message,value.timestamp, members) end)
    |> Enum.filter(fn pair -> !is_nil(pair) end)
  end

  def get_pair(commit_message,timestamp, members) do
    String.split(commit_message, [" ", "/", "\n"])
    |> Enum.map(&String.downcase(&1))
    |> Enum.filter(&Enum.member?(members, String.downcase(&1)))
    |> Enum.sort
    |> Pair.new(timestamp)
  end

  def matcher(str) when is_binary(str) do
    String.downcase(str) == "correct"
  end 

  def matcher(_), do: false

end
