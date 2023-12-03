defmodule UniApi.College do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  schema "colleges" do
    field :name, :string
    field :url, :string
    field :logo_url, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:name, :url, :logo_url])
      |> validate_required([:name, :url])
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

  def get_colleges() do
    result = UniApi.College
      |> UniApi.Repo.all

    result
  end

  def insert_new_colleges(data) do
    UniApi.Repo.insert(data)
  end
end
