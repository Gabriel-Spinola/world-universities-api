defmodule CollegeSpider.BasicSpider do
  defmodule JsonTemplate do
    @json_file_path "./output/output.json"

    def generate_college_json(college) do
      %{
        "name" => Map.get(college, :name, "default_name"),
        "url" => Map.get(college, :url, "default_url"),
        "logo_url" => Map.get(college, :logo_url, "default_logo_url")
      }
    end

    def read_json_file() do
      case File.read(@json_file_path) do
        {:ok, content} ->
          decoded_content = Jason.decode!(content, pretty: true)

          decoded_content

        {:error, reason} ->
          IO.puts("Error reading JSON file: #{reason}")

          %{}
      end
    end

    def append_college_data(college_data) do
      existing_data = read_json_file()

      universities =
        case Map.get(existing_data, "universities") do
          nil -> college_data

          existing_universities -> existing_universities ++ college_data
        end

      updated_data = Map.put(existing_data, "universities", universities)

      case File.write(@json_file_path, Jason.encode!(updated_data, pretty: true)) do
        :ok -> IO.puts("Data appended to the JSON file.")

        {:error, reason} -> IO.puts("Error writing to JSON file: #{reason}")
      end
    end
  end

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
          Crawly.Utils.build_absolute_url(url, response.request.url)
            |> Crawly.Utils.request_from_url()
        end)

    # NOTE - produces custom json output
    json_items = Enum.map(items, &JsonTemplate.generate_college_json/1)
    JsonTemplate.append_college_data(json_items)

    # NOTE - produces .js output
    %Crawly.ParsedItem {
      :items => [
        %{ universities: items, url: response.request_url },
      ],
      :requests => next_requests
    }
  end
end
