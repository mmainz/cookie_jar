defmodule CookieJarTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, pid} = CookieJar.start_link

    {:ok, %{pid: pid}}
  end

  test "it can be started", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "it can be named", %{test: test} do
    name = Module.concat(__MODULE__, test)
    CookieJar.start_link(name: name)

    assert name |> Process.whereis |> Process.alive?
  end

  test "it answers with the cookie jar", %{pid: pid} do
    assert %CookieJar{cookies: 0} == CookieJar.jar(pid)
  end

  test "grandma puts a cookie in the jar", %{pid: pid} do
    assert %CookieJar{cookies: 1} == CookieJar.grandma(pid)
  end

  test "kitty takes one cookie", %{pid: pid} do
    CookieJar.grandma(pid)

    assert %CookieJar{cookies: 0} == CookieJar.cat(pid)
  end

  test "kitty doesn't take cookies if there are none", %{pid: pid} do
    assert %CookieJar{cookies: 0} == CookieJar.cat(pid)
  end

  test "cookie monster takes all the cookies", %{pid: pid} do
    CookieJar.grandma(pid)
    CookieJar.grandma(pid)
    CookieJar.grandma(pid)

    assert %CookieJar{cookies: 0} == CookieJar.monster(pid)
  end

  test "cookie monster takes no cookies when there are none", %{pid: pid} do
    assert %CookieJar{cookies: 0} == CookieJar.monster(pid)
  end

  test "resetting the cookie jar sets cookies to 0", %{pid: pid} do
    CookieJar.grandma(pid)

    assert :ok == CookieJar.reset(pid)
    assert %CookieJar{cookies: 0} == CookieJar.jar(pid)
  end
end
