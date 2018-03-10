defmodule Xpar.Server.TeamServer do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: TeamServer)
  end

  def add_member(members) do
    GenServer.cast(TeamServer, {:add_members, members})
  end

  def get_members() do
    GenServer.call(TeamServer, {:get_members})
  end

  def handle_call({:get_members},pid, state) do
    {:reply,state, state}
  end

  def handle_cast({:add_members, members}, state) do
    {:noreply, members}
  end
end
