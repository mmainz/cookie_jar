# CookieJar

To make use of the distributed features of this project, you must start two
instances of the server with unique names. Also, they have to run on different
ports. To do this, type this in your terminal:

```
iex --sname node1 -S mix phx.server
```

And in another terminal type:

```
PORT=4001 iex --sname node2 -S mix phx.server
```

The two instances should auto-discover each other and start sharing the state of
the cookie jar. If you want to use different names or more nodes, you can
configure this in `config/dev.exs`. Check out
[libcluster](https://github.com/bitwalker/libcluster) for details.
