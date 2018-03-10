defmodule Xpar.PairingTest do
  use Xpar.DataCase

  alias Xpar.Pairing

  describe "pairs" do
    alias Xpar.Pairing.Pair

    @valid_attrs %{dev_1: "some dev_1", dev_2: "some dev_2"}
    @update_attrs %{dev_1: "some updated dev_1", dev_2: "some updated dev_2"}
    @invalid_attrs %{dev_1: nil, dev_2: nil}

    def pair_fixture(attrs \\ %{}) do
      {:ok, pair} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pairing.create_pair()

      pair
    end

    test "list_pairs/0 returns all pairs" do
      pair = pair_fixture()
      assert Pairing.list_pairs() == [pair]
    end

    test "get_pair!/1 returns the pair with given id" do
      pair = pair_fixture()
      assert Pairing.get_pair!(pair.id) == pair
    end

    test "create_pair/1 with valid data creates a pair" do
      assert {:ok, %Pair{} = pair} = Pairing.create_pair(@valid_attrs)
      assert pair.dev_1 == "some dev_1"
      assert pair.dev_2 == "some dev_2"
    end

    test "create_pair/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pairing.create_pair(@invalid_attrs)
    end

    test "update_pair/2 with valid data updates the pair" do
      pair = pair_fixture()
      assert {:ok, pair} = Pairing.update_pair(pair, @update_attrs)
      assert %Pair{} = pair
      assert pair.dev_1 == "some updated dev_1"
      assert pair.dev_2 == "some updated dev_2"
    end

    test "update_pair/2 with invalid data returns error changeset" do
      pair = pair_fixture()
      assert {:error, %Ecto.Changeset{}} = Pairing.update_pair(pair, @invalid_attrs)
      assert pair == Pairing.get_pair!(pair.id)
    end

    test "delete_pair/1 deletes the pair" do
      pair = pair_fixture()
      assert {:ok, %Pair{}} = Pairing.delete_pair(pair)
      assert_raise Ecto.NoResultsError, fn -> Pairing.get_pair!(pair.id) end
    end

    test "change_pair/1 returns a pair changeset" do
      pair = pair_fixture()
      assert %Ecto.Changeset{} = Pairing.change_pair(pair)
    end
  end
end
