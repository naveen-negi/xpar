defmodule Xpar.Teams.Members do

  defstruct [id: nil, members: nil]

  def new(id) do
    %Xpar.Teams.Members{id: id, members: []}
  end
  def add(team, members) do
    IO.inspect members
    %Xpar.Teams.Members{team | members: members }
  end
end
