defmodule Xpar.Services.PairingMatrixService do
  alias Xpar.Client.BitBucket
  alias Xpar.Server.TeamServer
  alias Xpar.Pairing.Pair
  alias Xpar.Pairing.Matrix

  @team_server  Xpar.Teams
  @bitbucket_client Xpar.Client.BitBucket

  def get_pairing_matrix(id) do
    members = @team_server.get(id)
    pairing_matrix = Matrix.new

    @bitbucket_client.get_commit_messages("","")
    |> Enum.map(fn message -> get_pair(message, members) end)
    |> Enum.filter(fn pair -> !is_nil(pair) end)
    |> Enum.reduce(pairing_matrix, fn (pair,acc) -> Matrix.add_pair(acc, pair) end)
  end

  defp get_pair({:ok, commit_message}, members) do
    String.split(commit_message, [" ", "/"])
    |> Enum.filter(&Enum.member?(members, &1))
    |> Pair.new
  end

end
