defmodule CookieJar do
  defstruct cookies: nil

  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    :ok = :net_kernel.monitor_nodes(true)
    {:ok, nil}
  end

  def handle_info({:nodeup, node}, state) do
    Logger.info "Node up! #{inspect node}"
    :rpc.call(node, CookieJar, :join_node, [Node.self])
    {:noreply, state}
  end

  def handle_info({:nodedown, node}, state) do
    {:noreply, state}
  end

  def setup do
    Logger.info "Setting up mnesia"
    :ok = :mnesia.start
    :mnesia.create_table(CookieJar, [attributes: [:id, :count]])
    :mnesia.wait_for_tables([CookieJar], 1_000)
    :mnesia.transaction(fn ->
      :mnesia.write({CookieJar, 1, 0})
    end)

    :ok
  end

  def join_node(master) do
    Logger.info "Joining #{inspect Node.self} to #{inspect master}"
    :mnesia.start
    :mnesia.delete_table(CookieJar)
    :mnesia.change_config(:extra_db_nodes, [master])
  end

  def jar do
    query = fn ->
      :mnesia.read({CookieJar, 1})
    end

    with {:atomic, [{CookieJar, 1, count}]} <- :mnesia.transaction(query),
      do: %CookieJar{cookies: count}
  end

  def grandma do
    query = fn ->
      [{CookieJar, 1, count}] = :mnesia.wread({CookieJar, 1})
      :ok = :mnesia.write({CookieJar, 1, count + 1})
      count + 1
    end

    with {:atomic, count} <- :mnesia.transaction(query),
      do: %CookieJar{cookies: count}
  end

  def cat do
    query = fn ->
      [{CookieJar, 1, count}] = :mnesia.wread({CookieJar, 1})
      :ok = :mnesia.write({CookieJar, 1, take_cookie(count)})
      take_cookie(count)
    end

    with {:atomic, count} <- :mnesia.transaction(query),
      do: %CookieJar{cookies: count}
  end

  def monster do
    query = fn ->
      :ok = :mnesia.write({CookieJar, 1, 0})
      0
    end

    with {:atomic, count} <- :mnesia.transaction(query),
      do: %CookieJar{cookies: count}
  end

  def reset do
    query = fn ->
      :ok = :mnesia.write({CookieJar, 1, 0})
      0
    end

    with {:atomic, 0} <- :mnesia.transaction(query),
      do: :ok
  end

  defp take_cookie(count) when count > 0, do: count - 1
  defp take_cookie(_), do: 0
end
