defmodule Xpar.Teams do
@storage_file Application.get_env(:xpar, :storage_file_name)

  def save(team) do
    {:ok, table} = :dets.open_file(@storage_file, [type: :set])
    :dets.insert_new(table, {team.id, team})
  end

  def get(id) do
    :dets.lookup(@storage_file, id)
  end

end
