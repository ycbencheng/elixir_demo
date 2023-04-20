defmodule Homework.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias Homework.Merchants.Merchant
  alias Homework.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do
    belongs_to(:merchant, Merchant, type: :binary_id, foreign_key: :merchant_id)
    belongs_to(:user, User, type: :binary_id, foreign_key: :user_id)

    has_one :company, through: [:user, :company]

    field(:amount, :integer)
    field(:credit, :boolean, default: false)
    field(:debit, :boolean, default: false)
    field(:description, :string)

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:user_id, :amount, :credit, :debit, :description, :merchant_id])
    |> validate_required([:user_id, :amount, :credit, :debit, :description, :merchant_id])
  end
end
