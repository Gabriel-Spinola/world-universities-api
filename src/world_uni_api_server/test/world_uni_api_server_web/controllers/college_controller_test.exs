defmodule WorldUniApiServerWeb.CollegeControllerTest do
  use WorldUniApiServerWeb.ConnCase

  import WorldUniApiServer.CollegesFixtures

  alias WorldUniApiServer.Colleges.College

  @create_attrs %{
    name: "some name",
    url: "some url",
    logo_url: "some logo_url"
  }
  @update_attrs %{
    name: "some updated name",
    url: "some updated url",
    logo_url: "some updated logo_url"
  }
  @invalid_attrs %{name: nil, url: nil, logo_url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all colleges", %{conn: conn} do
      conn = get(conn, ~p"/api/colleges")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create college" do
    test "renders college when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/colleges", college: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/colleges/#{id}")

      assert %{
               "id" => ^id,
               "logo_url" => "some logo_url",
               "name" => "some name",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/colleges", college: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update college" do
    setup [:create_college]

    test "renders college when data is valid", %{conn: conn, college: %College{id: id} = college} do
      conn = put(conn, ~p"/api/colleges/#{college}", college: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/colleges/#{id}")

      assert %{
               "id" => ^id,
               "logo_url" => "some updated logo_url",
               "name" => "some updated name",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, college: college} do
      conn = put(conn, ~p"/api/colleges/#{college}", college: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete college" do
    setup [:create_college]

    test "deletes chosen college", %{conn: conn, college: college} do
      conn = delete(conn, ~p"/api/colleges/#{college}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/colleges/#{college}")
      end
    end
  end

  defp create_college(_) do
    college = college_fixture()
    %{college: college}
  end
end
