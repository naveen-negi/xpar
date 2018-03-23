defmodule Xpar.Pairing.Matrix do
  alias Xpar.Pairing.Pair
  alias Xpar.Pairing.Stats

  defstruct [pairs: nil]

  def new  do
    %Xpar.Pairing.Matrix{pairs: []}
  end

  def add_pair(matrix, pairs) do
    result = [pairs | matrix.pairs]
    %Xpar.Pairing.Matrix{matrix | pairs: result}
  end

  def process_pairs(matrix) do
    pair_lookup = Enum.group_by(matrix.pairs, fn x -> distinct_by(x.first, x.second) end)
    total_days = length(Enum.uniq(matrix.pairs))
    result = Map.keys(pair_lookup)
    |> Enum.map(fn pair -> get_stats_for(pair_lookup, pair, total_days) end )
     result
  end

  defp get_stats_for(lookup, pair, total_pair_days) do
    pairs = Map.fetch!(lookup, pair)
    [pair | _ ] = pairs
    days_paired = length(Enum.uniq_by(pairs, fn pair -> pair.timestamp end))
    paired_percentage = get_paired_percentage(total_pair_days, days_paired)

    %Stats{ first_pair: pair.first,
            second_pair: pair.second,
            days_paired: days_paired,
           percent: paired_percentage}
  end

  defp distinct_by(first, second) when is_nil(second) do
    first
  end

  defp distinct_by(first, second) when is_nil(first) do
    first
  end

  defp distinct_by(first, second) do
    first <> second
  end

  defp get_paired_percentage(total_days, number_of_paired) do
     number_of_paired/total_days *100
  end

  defp days_paired(pair_lookup, pair) do
    length(Map.fetch!(pair_lookup, pair))
  end
end
