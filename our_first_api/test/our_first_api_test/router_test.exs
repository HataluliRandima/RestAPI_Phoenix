defmodule OurFirstApiTest.RouterTest do
  use ExUnit.Case, async: true

  #This allows our conn object to be available within the test
  use Plug.Test
  doctest OurFirstApi

  #module attribute
  @opts OurFirstApi.Router.init([])

  test "return ok" do
    # build connection to our request.
    build_conn = conn(:get, "/")
    conn = OurFirstApi.Router.call(build_conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK"
  end
end
