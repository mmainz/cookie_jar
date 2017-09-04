defmodule CookieJarWeb.ActionControllerTest do
  use CookieJarWeb.ConnCase, async: false

  setup do
    CookieJar.reset(CookieJar)
  end

  describe "/cookies" do
    test "it returns the current cookie count" do
      result = build_conn()
      |> get("/cookies")
      |> json_response(200)

      assert %{"cookies" => 0} == result
    end
  end

  describe "/cat" do
    test "it returns the new cookie count" do
      result = build_conn()
      |> get("/cat")
      |> json_response(200)

      assert %{"cookies" => 0} == result
    end

    test "it reduces the cookie count by one" do
      CookieJar.grandma(CookieJar)
      result = build_conn()
      |> get("/cat")
      |> json_response(200)

      assert %{"cookies" => 0} == result
    end
  end

  describe "/grandma" do
    test "it increases the cookie count by one" do
      result = build_conn()
      |> get("/grandma")
      |> json_response(200)

      assert %{"cookies" => 1} == result
    end
  end

  describe "/monster" do
    test "it takes all the cookies" do
      CookieJar.grandma(CookieJar)
      CookieJar.grandma(CookieJar)
      CookieJar.grandma(CookieJar)

      result = build_conn()
      |> get("/monster")
      |> json_response(200)

      assert %{"cookies" => 0} == result
    end
  end
end
