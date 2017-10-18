defmodule CookieJarWeb.ActionController do
  use CookieJarWeb, :controller

  def cookies(conn, _) do
    conn
    |> put_status(200)
    |> json(CookieJar.jar)
  end

  def cat(conn, _) do
    conn
    |> put_status(200)
    |> json(CookieJar.cat)
  end

  def grandma(conn, _) do
    conn
    |> put_status(200)
    |> json(CookieJar.grandma)
  end

  def monster(conn, _) do
    conn
    |> put_status(200)
    |> json(CookieJar.monster)
  end
end
