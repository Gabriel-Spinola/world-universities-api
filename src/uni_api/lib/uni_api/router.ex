defmodule UniApi.Router do
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
  get "colleges", do: get_colleges(conn)

  match _, do: send_resp(conn, 404, "Not Found")

  defp get_colleges(conn) do
    colleges = [
      %{id: 1, name: "College A", url: "collge.com", img_url: "a.png"},
      %{id: 2, name: "College B", url: "collge.com", img_url: "a.png"},
      %{id: 3, name: "College C", url: "collge.com", img_url: "a.png"},
      %{id: 4, name: "College D", url: "collge.com", img_url: "a.png"}
    ]

    json_payload = Jason.encode!(colleges)
    send_resp(conn, 200, json_payload)
  end
end
