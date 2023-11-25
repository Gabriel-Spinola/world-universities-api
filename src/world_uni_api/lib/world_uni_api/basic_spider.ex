defmodule BasicSpider do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://univ.cc/search.php?dom=world&key=&start=1"

  @impl Crawly.Spider
  def init() do
    [start_urls: ["https://univ.cc/search.php?dom=world&key=&start=1"]]
  end

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} = Floki.parse_document(response.body)

    items =
      document
      |> Floki.find("ol li")
      |> Enum.map(fn uni ->
          %{
            name: Floki.find(uni, "a") |> Floki.text(),
            url: Floki.attribute(uni, "a", "href") |> Floki.text()
          }
        end)

    next_requests =
      document
      |> Floki.find("nav a")
      |> Floki.attribute("href")
      |> Enum.filter(&String.contains?(&1, "&start="))
      |> Enum.map(fn url ->
          checked_url =
            if String.contains?(url, "&start") do
              url
            end

          Crawly.Utils.build_absolute_url(checked_url, response.request.url)
          |> Crawly.Utils.request_from_url()
        end)

    %Crawly.ParsedItem {
      :items => [
        %{ universities: items, url: response.request_url }
      ],
      :requests => next_requests
    }
  end
end
