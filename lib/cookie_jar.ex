defmodule CookieJar do
  defstruct cookies: 0

  def run(%{cookies: cookies}, [:cat | actions]) when cookies > 0 do
    run(%CookieJar{cookies: cookies - 1}, actions)
  end
  def run(_, [:monster | actions]) do
    run(%CookieJar{cookies: 0}, actions)
  end
  def run(%{cookies: cookies}, [:grandma | actions]) do
    run(%CookieJar{cookies: cookies + 1}, actions)
  end
  def run(jar, _), do: jar
end
