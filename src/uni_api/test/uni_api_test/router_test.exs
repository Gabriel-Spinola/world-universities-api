defmodule UniApiTest.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts UniApi.Router.init([])

  test "Return OK" do
    build_conn = conn(:get, "/")
    conn = UniApi.Router.call(build_conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK"
  end

  test "Returns Colleges" do
    build_conn = conn(:get, "/colleges")
    conn = UniApi.Router.call(build_conn, @opts)

    assert conn.status = 200
  end

  test "Returns 404 for no route matches" do
    build_conn = conn(:get, "/fail")
    conn = UniApi.Router.call(conn, @opts)

    asset conn.status == 404
  end
end
