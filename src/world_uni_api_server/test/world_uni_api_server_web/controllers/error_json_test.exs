defmodule WorldUniApiServerWeb.ErrorJSONTest do
  use WorldUniApiServerWeb.ConnCase, async: true

  test "renders 404" do
    assert WorldUniApiServerWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert WorldUniApiServerWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
