defmodule CookieJarWeb.ActionController do
  use CookieJarWeb, :controller

  def cookies(conn, _) do
    conn
    |> put_status(200)
    |> json(CookieJar.jar(CookieJar))
  end

  def cat(conn, _) do
    conn
    |> put_status(200)
    |> json(CookieJar.cat(CookieJar))
  end

  def grandma(conn, _) do
    conn
    |> put_status(200)
    |> json(CookieJar.grandma(CookieJar))
  end

  def monster(conn, _) do
    conn
    |> put_status(200)
    |> json(CookieJar.monster(CookieJar))
  end
end
