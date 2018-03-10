defmodule XparWeb.PairView do
  use XparWeb, :view
  alias XparWeb.PairView

  def render("index.json", %{pairs: pairs}) do
    %{data: render_many(pairs, PairView, "pair.json")}
  end

  def render("show.json", %{pair: pair}) do
    %{data: render_one(pair, PairView, "pair.json")}
  end

  def render("pair.json", %{pair: pair}) do
    %{id: pair.id,
      dev_1: pair.dev_1,
      dev_2: pair.dev_2}
  end
end
