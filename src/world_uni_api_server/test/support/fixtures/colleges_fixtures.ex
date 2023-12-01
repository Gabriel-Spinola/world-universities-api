defmodule WorldUniApiServer.CollegesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `WorldUniApiServer.Colleges` context.
  """

  @doc """
  Generate a college.
  """
  def college_fixture(attrs \\ %{}) do
    {:ok, college} =
      attrs
      |> Enum.into(%{
        logo_url: "some logo_url",
        name: "some name",
        url: "some url"
      })
      |> WorldUniApiServer.Colleges.create_college()

    college
  end
end
