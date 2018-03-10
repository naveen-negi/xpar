defmodule Xpar.PairingMatrixService do
  alias Xpar.Client.BitBucketClient
  alias Xpar.Server.TeamServer

  def get_pairing_matrix do
    commit_messages = BitBucketClient.get_commit_messages
    members = TeamServer.get_members
    Enum.map(commit_messages, fn message -> get_pair(message, members) end)
  end

  defp get_pair(commit_message, members) do
    Enum.filter(members, fn name -> String.contains?(commit_message, name)  end)
  end

end
