# defmodule Xpar.Server.TeamServer do
#   use Agent 

#   def start_link(state) do
#     Agent.start_link(fn -> state end, name: __MODULE__)
#   end

  # def add_member(member_list) do
  #   Agent.update(__MODULE__, fn state -> [member_list ++ state] end)
  # end

  # def get_members() do
  #   Agent.get(__MODULE__, fn state -> state end)
  # end

# end
