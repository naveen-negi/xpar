defmodule Xpar.TeamTest do
  use Xpar.DataCase

  alias Xpar.Team

  describe "stats" do
    alias Xpar.Team.Stat

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def stat_fixture(attrs \\ %{}) do
      {:ok, stat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Team.create_stat()

      stat
    end

    test "list_stats/0 returns all stats" do
      stat = stat_fixture()
      assert Team.list_stats() == [stat]
    end

    test "get_stat!/1 returns the stat with given id" do
      stat = stat_fixture()
      assert Team.get_stat!(stat.id) == stat
    end

    test "create_stat/1 with valid data creates a stat" do
      assert {:ok, %Stat{} = stat} = Team.create_stat(@valid_attrs)
    end

    test "create_stat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_stat(@invalid_attrs)
    end

    test "update_stat/2 with valid data updates the stat" do
      stat = stat_fixture()
      assert {:ok, stat} = Team.update_stat(stat, @update_attrs)
      assert %Stat{} = stat
    end

    test "update_stat/2 with invalid data returns error changeset" do
      stat = stat_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_stat(stat, @invalid_attrs)
      assert stat == Team.get_stat!(stat.id)
    end

    test "delete_stat/1 deletes the stat" do
      stat = stat_fixture()
      assert {:ok, %Stat{}} = Team.delete_stat(stat)
      assert_raise Ecto.NoResultsError, fn -> Team.get_stat!(stat.id) end
    end

    test "change_stat/1 returns a stat changeset" do
      stat = stat_fixture()
      assert %Ecto.Changeset{} = Team.change_stat(stat)
    end
  end
end
