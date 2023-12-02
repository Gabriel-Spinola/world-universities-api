defmodule UniApi.Router do
  #alias ElixirSense.Plugins.Ecto
  use Plug.Router
  require Ecto.Query

  plug Plug.Logger, log: :debug

  # NOTE - match and parse
  plug :match

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug :dispatch

  get "/", do: send_resp(conn, 200, "OK")
  get "colleges", do: get_colleges(conn)

  match _, do: send_resp(conn, 404, "Not Found")

  defp get_colleges(conn) do
    query = UniApi.College
      |> Ecto.Query.first

    result = UniApi.Repo.one(query)

    case result do
      %UniApi.College{} ->
        result_map = Map.from_struct(result)
          |> Map.delete(:__meta__)

        encoded_result = Jason.encode!(result_map)
        send_resp(conn, 200, encoded_result)

      nil -> send_resp(conn, 404, "Not Found")
    end
  end
end
