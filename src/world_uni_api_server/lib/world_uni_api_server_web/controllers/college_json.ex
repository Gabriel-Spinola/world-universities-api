defmodule WorldUniApiServerWeb.CollegeJSON do
  alias WorldUniApiServer.Colleges.College

  @doc """
  Renders a list of colleges.
  """
  def index(%{colleges: colleges}) do
    %{data: for(college <- colleges, do: data(college))}
  end

  @doc """
  Renders a single college.
  """
  def show(%{college: college}) do
    %{data: data(college)}
  end

  defp data(%College{} = college) do
    %{
      id: college.id,
      name: college.name,
      url: college.url,
      logo_url: college.logo_url
    }
  end
end
