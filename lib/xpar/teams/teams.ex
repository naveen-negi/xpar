defmodule Xpar.Teams do
@repo_storage_file Application.get_env(:xpar, :storage_file_name)
@members_storage_file Application.get_env(:xpar, :members_storage_file_name)

  def add_repos(team) do
    {:ok, table} = :dets.open_file(@repo_storage_file, [type: :set])
    :dets.insert(table, {team.id, team})
  end

  def get_repos(id) do
      [head | _] = :dets.lookup(@repo_storage_file, id)
      elem(head, 1)
  end

  def add_members(team) do
    {:ok, table} = :dets.open_file(@members_storage_file, [type: :set])
    :dets.insert(table, {team.id, team})
  end

  def get_members(id) do
    [head | _] = :dets.lookup(@members_storage_file, id)
    elem(head, 1)
  end

end
