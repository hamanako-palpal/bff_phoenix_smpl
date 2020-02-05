defmodule StateServer do
  use GenServer

  def start_link do
    GenServer.start_link(StateServer, [], name: :user_state)
  end

  def init(_) do {:ok, []} end

  def login(id, pw) do
    GenServer.call(:user_state, {:login, %User{id: id, pw: pw}})
  end

  def viewActiveUsers do
    GenServer.call(:user_state, :view)
  end

  def handle_call({:login, user}, _from, state) do
    isLogin user, state
  end

  def handle_call(:view, _from, state) do

    IO.inspect(state)
    {:reply, state, state}
  end

  def isLogin(user, activeUsers) do
    FileAccess.read(:json_user)
      |> Enum.any?(&(Map.equal?(user, &1)))
      |> isLogin(user, activeUsers)
  end

  def isLogin(true, user, activeUsers) do

    IO.inspect "true"
    activeUsers = activeUsers ++ [user]
    {:reply, activeUsers, activeUsers}
  end

  def isLogin(false, _,  activeUsers) do
    IO.inspect "false"
    {:reply, activeUsers, activeUsers}
  end

end
