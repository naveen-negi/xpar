defmodule Xpar.Client.BitBucket do
  @bitbucket_url  "https://api.bitbucket.org/2.0/repositories"

  def get_commit_messages(team, repo_name) do
    response = HTTPoison.get! "#{@bitbucket_url}/#{team}/#{repo_name}/commits/"
    IO.inspect response
    {:ok, response_map}= Poison.decode(response.body)
     {:ok, values} = Map.fetch(response_map, "values")
     Enum.map(values, &Map.fetch(&1, "message"))
  end
end
