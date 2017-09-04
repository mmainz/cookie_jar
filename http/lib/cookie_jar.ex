defmodule CookieJar do
  defstruct cookies: 0

  def start_link(options \\ []) do
    Agent.start_link(fn -> %CookieJar{} end, options)
  end

  def jar(cookie_jar) do
    Agent.get(cookie_jar, &(&1))
  end

  def grandma(cookie_jar) do
    Agent.update(cookie_jar, &Map.update(&1, :cookies, 0, fn n -> n + 1 end))
    jar(cookie_jar)
  end

  def cat(cookie_jar) do
    Agent.update(cookie_jar, &Map.update(&1, :cookies, 0, fn
          n when n > 0 -> n - 1
          _ -> 0
        end))
    jar(cookie_jar)
  end

  def monster(cookie_jar) do
    Agent.update(cookie_jar, &Map.update(&1, :cookies, 0, fn _ -> 0 end))
    jar(cookie_jar)
  end

  def reset(cookie_jar) do
    Agent.update(cookie_jar, &Map.update(&1, :cookies, 0, fn _ -> 0 end))
  end
end
