defmodule Xpar.Repo.Migrations.CreateTeams do
  use Ecto.Migration

  def change do
    create table(:teams) do

      timestamps()
    end

  end
end
