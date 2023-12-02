defmodule UniApi.Router do
  #alias ElixirSense.Core.Struct
  #alias ElixirSense.Plugins.Ecto
  use Plug.Router

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

  get "colleges" do
    results = UniApi.College.get_colleges()

    mapped_result = Enum.map(results, fn result ->
      case result do
        %UniApi.College{} ->
          result_map = Map.from_struct(result)
            |> Map.delete(:__meta__)

          result_map

        nil -> %{}
      end
    end)

    if length(mapped_result) <= 0 do
      send_resp(conn, 404, "Not Found")
    end

    encoded_result = Jason.encode!(mapped_result)
    send_resp(conn, 200, encoded_result)
  end

  post "colleges" do
    IO.inspect(%UniApi.College{})
    fields = Map.keys(%UniApi.College{})
      |> Enum.map(&Atom.to_string/1)

    {status, body} =
      if Enum.any?(fields, &Map.has_key?(conn.body_params, &1)) do
        changeset = UniApi.College.changeset(%UniApi.College{}, %{
          "name" => conn.body_params["name"],
          "url" => conn.body_params["url"],
          "logo_url" => conn.body_params["logo_url"]
        })

        case UniApi.College.insert_new_colleges(changeset) do
          {:ok, record} -> {200, ""}
          {:error, changeset} -> {422, Jason.encode!(changeset.errors)}
        end

        {500, "Something went wrong"}
      else
        { 422, missing_body_data() }
      end

    send_resp(conn, status, body)
  end

  match _, do: send_resp(conn, 404, "Not Found")

  defp missing_body_data do
    Jason.encode!(%{error: "Expected Payload: { 'data': [...] }"})
  end
end
