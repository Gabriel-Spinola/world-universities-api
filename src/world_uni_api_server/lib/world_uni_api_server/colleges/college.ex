defmodule WorldUniApiServer.Colleges.College do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "colleges" do
    field :name, :string
    field :url, :string
    field :logo_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(college, attrs) do
    college
    |> cast(attrs, [:name, :url, :logo_url])
    |> validate_required([:name, :url, :logo_url])
  end
end
