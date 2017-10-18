# CookieJar

An Elixir implementation of the
[cookie jar](https://github.com/joyclark/cookie-jar).

There are multiple implementations of the problem:

- `simple` contains a pure business logic implementation
- `http` contains a solution that is accessed by HTTP. This makes it more
  interesting, because the state has to be persisted between requests
- `distributed` also contains an HTTP solution, but this one can share the state
  across multiple instances
