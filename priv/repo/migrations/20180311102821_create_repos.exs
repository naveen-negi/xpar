defmodule Xpar.Repo.Migrations.CreateRepos do
  use Ecto.Migration

  def change do
    create table(:repos) do

      timestamps()
    end

  end
end
