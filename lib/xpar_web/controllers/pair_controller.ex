defmodule XparWeb.PairController do
  use XparWeb, :controller

  alias Xpar.Pairing.Matrix
  alias Xpar.Pairing.Pair
  alias Xpar.Services.PairingMatrixService

  def get(conn, _params) do
    id = conn.params["id"]
    matrix = PairingMatrixService.get_pairing_matrix(id)
    conn
    |> put_resp_content_type("application/json")
    |> put_status(200)
    |> json(matrix)
  end

end
