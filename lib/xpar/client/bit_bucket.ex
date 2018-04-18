defmodule Xpar.Client.BitBucket do
  @bitbucket_url Application.get_env(:xpar, :base_url)

  def get_commit_messages(team, repo_name) do
    get_messages(team, repo_name, 0, [])
  end

  defp get_messages(team, repo_name, start, commit_messages) when start > 20 do
    commit_messages
  end

  defp get_messages(team, repo_name, start, commit_messages) when is_nil(start) do
    commit_messages
  end

  defp get_messages(team, repo_name, start, commit_messages) do
    response = HTTPoison.get! "#{@bitbucket_url}/#{team}/repos/#{repo_name}/commits/?start=#{start}"
    body = Poison.decode!(response.body)
    case Map.fetch(body, "errors") do
      {:ok, _} -> []
      _ ->
            pagination_result = get_pagination_result(body)
            commit_messages = commit_messages ++ get_commit_messages_from_response(body)
            get_messages(team, repo_name, pagination_result.next_page_start, commit_messages)
    end
  end

  def get_pagination_result(body) do
    case Map.fetch(body, "isLastPage") do
      {:ok, false} -> %{is_last_page: false, next_page_start: Map.fetch!(body, "nextPageStart")} 
       _ -> %{is_last_page: true, next_page_start: nil}
    end
  end

  def get_commit_messages_from_response(body)do
    body
    |> Map.fetch!("values")
    |> Enum.map(fn value ->  %{message: Map.fetch!(value, "message"), timestamp: get_time_stamp(value)} end)
  end

  def get_all_projects_for(team) do
    get_repos(team, 0, false, [])
  end

  def get_repos(team, start, is_last_page, state) when is_last_page == true do
    state
  end

  def get_repos(team, start, is_last_page, state) do
    response = HTTPoison.get! "#{@bitbucket_url}/#{team}/repos?start=#{start}"
    {:ok, response_map}= Poison.decode(response.body)
    pagination_result = get_pagination_result(response_map)

    repos =
    Map.fetch!(response_map, "values")
    |> Enum.map( fn value -> %{repo_name: Map.fetch!(value, "name"), id: Map.fetch!(value, "id")} end)
    get_repos(team, pagination_result.next_page_start, pagination_result.is_last_page, state ++ repos)
  end

  def get_time_stamp(value) do
    value
    |> Map.fetch!("authorTimestamp")
    |> DateTime.from_unix!(:millisecond)
    |> DateTime.to_date
  end
end
