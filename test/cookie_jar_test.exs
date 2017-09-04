defmodule CookieJarTest do
  use ExUnit.Case

  test "it returns the jar if actions is empty" do
    jar = %CookieJar{}
    assert jar == CookieJar.run(jar, [])
  end

  test "it takes one cookie if the cat has the jar" do
    jar = %CookieJar{cookies: 2}
    assert %CookieJar{cookies: 1} == CookieJar.run(jar, [:cat])
  end

  test "the cat does not reduce cookie count below zero" do
    jar = %CookieJar{cookies: 0}
    assert %CookieJar{cookies: 0} == CookieJar.run(jar, [:cat])
  end

  test "the monster takes all the cookies" do
    jar = %CookieJar{cookies: 5}
    assert %CookieJar{cookies: 0} == CookieJar.run(jar, [:monster])
  end

  test "the monster does not reduce cookie count below zero" do
    jar = %CookieJar{cookies: 0}
    assert %CookieJar{cookies: 0} == CookieJar.run(jar, [:monster])
  end

  test "the grandma puts a cookie in the jar" do
    jar = %CookieJar{cookies: 0}
    assert %CookieJar{cookies: 1} == CookieJar.run(jar, [:grandma])
  end
end
