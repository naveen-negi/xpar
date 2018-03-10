defmodule XparWeb.PairControllerTest do
  use XparWeb.ConnCase

  alias Xpar.Pairing
  alias Xpar.Pairing.Pair

  @create_attrs %{dev_1: "some dev_1", dev_2: "some dev_2"}
  @update_attrs %{dev_1: "some updated dev_1", dev_2: "some updated dev_2"}
  @invalid_attrs %{dev_1: nil, dev_2: nil}

  def fixture(:pair) do
    {:ok, pair} = Pairing.create_pair(@create_attrs)
    pair
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

    test "get pairing data for last two weeks", %{conn: conn} do
    paring_data = Pairing.add_pair( %Pair{dev_1: "superman", dev_2: "batman"})
    conn = get conn,"/pairing-data" 
    assert conn.status == 200
    assert conn.resp_body == Poison.encode!(pairing_data)
    end

end
