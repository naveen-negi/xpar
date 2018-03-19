defmodule XparWeb.StatView do
  use XparWeb, :view

  def pairs(conn) do
      stats = conn.assigns[:stats]
      IO.inspect stats
      stats
  end
end
