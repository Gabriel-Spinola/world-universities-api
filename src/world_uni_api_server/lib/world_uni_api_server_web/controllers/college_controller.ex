defmodule WorldUniApiServerWeb.CollegeController do
  use WorldUniApiServerWeb, :controller

  alias WorldUniApiServer.Colleges
  alias WorldUniApiServer.Colleges.College

  action_fallback WorldUniApiServerWeb.FallbackController

  def index(conn, _params) do
    colleges = Colleges.list_colleges()
    render(conn, :index, colleges: colleges)
  end

  def create(conn, %{"college" => college_params}) do
    with {:ok, %College{} = college} <- Colleges.create_college(college_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/colleges/#{college}")
      |> render(:show, college: college)
    end
  end

  def show(conn, %{"id" => id}) do
    college = Colleges.get_college!(id)
    render(conn, :show, college: college)
  end

  def update(conn, %{"id" => id, "college" => college_params}) do
    college = Colleges.get_college!(id)

    with {:ok, %College{} = college} <- Colleges.update_college(college, college_params) do
      render(conn, :show, college: college)
    end
  end

  def delete(conn, %{"id" => id}) do
    college = Colleges.get_college!(id)

    with {:ok, %College{}} <- Colleges.delete_college(college) do
      send_resp(conn, :no_content, "")
    end
  end
end
