defmodule CookieJarTest do
  use ExUnit.Case, async: true

  setup do
    :ok = CookieJar.setup
    :ok = CookieJar.reset
  end

  test "it answers with the cookie jar" do
    assert %CookieJar{cookies: 0} == CookieJar.jar
  end

  test "grandma puts a cookie in the jar" do
    assert %CookieJar{cookies: 1} == CookieJar.grandma
  end

  test "kitty takes one cookie" do
    CookieJar.grandma

    assert %CookieJar{cookies: 0} == CookieJar.cat
  end

  test "kitty doesn't take cookies if there are none" do
    assert %CookieJar{cookies: 0} == CookieJar.cat
  end

  test "cookie monster takes all the cookies" do
    CookieJar.grandma
    CookieJar.grandma
    CookieJar.grandma

    assert %CookieJar{cookies: 0} == CookieJar.monster
  end

  test "cookie monster takes no cookies when there are none" do
    assert %CookieJar{cookies: 0} == CookieJar.monster
  end

  test "resetting the cookie jar sets cookies to 0" do
    CookieJar.grandma

    assert :ok == CookieJar.reset
    assert %CookieJar{cookies: 0} == CookieJar.jar
  end
end
