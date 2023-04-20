defmodule Homework.Repo.Migrations.CreateCompanies do
  use Ecto.Migration
  import Ecto.Changeset

  def change do
    create table(:companies, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :credit_line, :integer
      add :available_credit, :integer

      timestamps()
    end

    create unique_index(:companies, [:name])
  end
end
