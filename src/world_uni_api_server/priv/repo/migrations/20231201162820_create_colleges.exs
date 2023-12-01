defmodule WorldUniApiServer.Repo.Migrations.CreateColleges do
  use Ecto.Migration

  def change do
    create table(:colleges, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :url, :string
      add :logo_url, :string

      timestamps(type: :utc_datetime)
    end
  end
end
