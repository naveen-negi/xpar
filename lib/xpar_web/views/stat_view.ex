defmodule XparWeb.StatView do
  use XparWeb, :view

  def pairs(conn) do
      stats = conn.assigns[:stats]
      stats
  end
end
