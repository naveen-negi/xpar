defmodule XparWeb.StatController do
  use XparWeb, :controller
  alias Xpar.Services.PairingMatrixService

  def show(conn, _params) do
     pairs = PairingMatrixService.get_pairing_matrix("knav")
    render conn, "show.html",
      stats: pairs
  end 
end
