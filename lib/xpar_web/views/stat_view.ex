defmodule XparWeb.StatView do
  use XparWeb, :view

  def pairs(conn) do
    conn.assigns[:stats]
     |> Enum.sort_by(fn stat -> stat.percent end)
  end
end
