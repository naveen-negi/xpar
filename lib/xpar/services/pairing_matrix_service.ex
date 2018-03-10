defmodule Xpar.PairingMatrixService do
  alias Xpar.Client.BitBucket
  alias Xpar.Server.TeamServer
  alias Xpar.Pairing.Pair

  def get_pairing_matrix do
    members = TeamServer.get_members

    BitBucket.get_commit_messages
    |> Enum.map(fn message -> get_pair(message, members) end)
    |> Enum.filter(fn pair -> !is_nil(pair) end)
  end

  defp get_pair({:ok, commit_message}, members) do
    String.split(commit_message, [" ", "/"])
    |> Enum.filter(&Enum.member?(members, &1))
    |> Pair.new
  end

end
