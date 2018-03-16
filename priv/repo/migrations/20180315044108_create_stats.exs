defmodule Xpar.Repo.Migrations.CreateStats do
  use Ecto.Migration

  def change do
    create table(:stats) do

      timestamps()
    end

  end
end
