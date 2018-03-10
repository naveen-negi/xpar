defmodule Xpar.Repo.Migrations.CreatePairs do
  use Ecto.Migration

  def change do
    create table(:pairs) do
      add :dev_1, :string
      add :dev_2, :string

      timestamps()
    end

  end
end
