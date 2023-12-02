defmodule UniApiTest.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts UniApi.Router.init([])

  setup do
    seed_test_data()
  end

  test "Returns encoded college when found" do
    conn = conn(:get, "/colleges")
    response = UniApi.Router.call(conn, @opts)

    assert response.status == 200
    assert response.resp_body == ~s({"id": "123", "name": "Test College", "url": "http://example.com", "logo_url": null})
  end

  test "Returns 404 when no college is found" do
    conn = conn(:get, "/colleges")
    response = UniApi.Router.call(conn, @opts)

    assert response.status == 404
    assert response.resp_body == "Not Found"
  end

  test "Return OK" do
    build_conn = conn(:get, "/")
    conn = UniApi.Router.call(build_conn, @opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "OK"
  end

  test "Returns 404 for no route matches" do
    build_conn = conn(:get, "/fail")
    conn = UniApi.Router.call(build_conn, @opts)

    assert conn.status == 404
  end

  # Mock function to simulate database seeding
  defp seed_test_data do
    %UniApi.College{
      id: "123",
      name: "Test College",
      url: "http://example.com",
      logo_url: "https://image.webpg"
    }
    |> UniApi.Repo.insert!()
  end
end
