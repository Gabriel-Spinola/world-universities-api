defmodule UniApi.College do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "college" do
    field :name, :string
    field :url, :string
    field :logo_url, :string

    timestamps()
  end

  defp all_fields do
    __MODULE__.__schema__(:fields)
  end
end
