defmodule Xpar.Client.BitBucket do
  @bitbucket_url Application.get_env(:xpar, :base_url)
  def get_commit_messages(team, repo_name) do
    IO.puts "**************************************************"
    IO.inspect @bitbucket_url
    IO.puts "**************************************************"
     response = HTTPoison.get! "#{@bitbucket_url}/#{team}/repos/#{repo_name}/commits/"
    {:ok, response_map}= Poison.decode(response.body)
    IO.inspect response_map
     {:ok, values} = Map.fetch(response_map, "values")
     Enum.map(values, fn value -> %{message: Map.fetch!(value, "message"), timestamp: DateTime.to_date(DateTime.from_unix!(Map.fetch!(value, "authorTimestamp"), :millisecond))} end)
  end
end
