defmodule UniApi.College do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "colleges" do
    field :name, :string
    field :url, :string
    field :logo_url, :string

    timestamps()
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end

  defimpl Jason.Encoder do
    def encode(data, _opts) do
      %{
        "id" => data.id,
        "name" => data.name,
        "url" => data.url,
        "logo_url" => data.logo_url,
        "inserted_at" => data.inserted_at,
        "updated_at" => data.updated_at
      }
    end
  end
end
