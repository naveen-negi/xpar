defmodule Xpar.Client.BitBucket do
  @bitbucket_url Application.get_env(:xpar, :base_url)

  def get_commit_messages(team, repo_name) do
    commit_messages =
    get_all_projects_for(team)
    |> Enum.map(fn result -> get_messages(team, result.repo_name, 0, []) end)
    IO.puts "*******************************************"
    IO.inspect "done with fetching commit messages" 
    IO.puts "*******************************************"
    commit_messages
  end

  defp get_messages(team, repo_name, start, commit_messages) when start > 30 do
    commit_messages
  end

  defp get_messages(team, repo_name, start, commit_messages) do
    response = HTTPoison.get! "#{@bitbucket_url}/#{team}/repos/#{repo_name}/commits/?start=#{start}"
    body = Poison.decode!(response.body)
    pagination_result = get_pagination_result(body)
    commit_messages = commit_messages ++ get_commit_messages_from_response(body)
    IO.puts "*******************************************"
    IO.inspect commit_messages
    IO.puts "*******************************************"
    get_messages(team, repo_name, pagination_result.next_page_start, commit_messages)
  end

  def get_pagination_result(body) do
    %{is_last_page: Map.fetch!(body, "isLastPage"), next_page_start: Map.fetch!(body, "nextPageStart")}
  end

  def get_commit_messages_from_response(body)do
    body
    |> Map.fetch!("values")
    |> Enum.map(fn value ->  %{message: Map.fetch!(value, "message"), timestamp: get_time_stamp(value)} end)
  end

  def get_all_projects_for(team) do
    response = HTTPoison.get! "#{@bitbucket_url}/#{team}/repos"
    {:ok, response_map}= Poison.decode(response.body)

    Map.fetch!(response_map, "values")
    |> Enum.map( fn value -> %{repo_name: Map.fetch!(value, "name"), id: Map.fetch!(value, "id")} end)
  end

  def get_time_stamp(value) do
    value
    |> Map.fetch!("authorTimestamp")
    |> DateTime.from_unix!(:millisecond)
    |> DateTime.to_date
  end
end
