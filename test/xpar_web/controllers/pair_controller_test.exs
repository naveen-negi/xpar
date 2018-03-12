defmodule XparWeb.PairControllerTest do
  use XparWeb.ConnCase

  test "should get pairing-matrux", %{conn: conn} do
    id = "team-2"
    conn = get conn, "api/teams/#{id}/pairing-matrix"
    response =
    conn
    |> get("api/pairing-matrix")
    |> json_response(200)
    assert !is_nil(response)
  end


end
