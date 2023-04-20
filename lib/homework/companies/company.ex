defmodule Homework.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "companies" do
    field :available_credit, :integer
    field :credit_line, :integer
    field :name, :string

    has_many :users, Homework.Users.User

    has_many :transactions, through: [:users, :transactions]

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :credit_line, :available_credit])
    |> validate_required([:name, :credit_line, :available_credit])
    |> unique_constraint(:name)
  end
end
