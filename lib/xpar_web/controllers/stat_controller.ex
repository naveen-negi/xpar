defmodule XparWeb.StatController do
  use XparWeb, :controller
  alias Xpar.Services.PairingMatrixService

  def show(conn, _params) do
    team = conn.params["id"]
     pairs = PairingMatrixService.get_pairing_matrix(team)
    render conn, "show.html",
      stats: pairs
  end 
end
