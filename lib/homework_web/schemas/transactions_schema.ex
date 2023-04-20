defmodule HomeworkWeb.Schemas.TransactionsSchema do
  @moduledoc """
  Defines the graphql schema for transactions.
  """
  use Absinthe.Schema.Notation

  alias HomeworkWeb.Resolvers.TransactionsResolver

  object :transaction do
    field(:id, non_null(:id))
    field(:user_id, :id)
    field(:amount, :integer)
    field(:credit, :boolean)
    field(:debit, :boolean)
    field(:description, :string)
    field(:merchant_id, :id)

    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)

    field(:user, :user) do
      resolve(&TransactionsResolver.user/3)
    end

    field(:merchant, :merchant) do
      resolve(&TransactionsResolver.merchant/3)
    end

    @desc "get transaction's user"
    field(:get_transaction_user, :user) do
      arg(:id, non_null(:id))

      resolve(&TransactionsResolver.get_transaction_user/3)
    end

    @desc "get transaction's company"
    field(:get_transaction_company, :company) do
      arg(:id, non_null(:id))

      resolve(&TransactionsResolver.get_transaction_company/3)
    end

    @desc "get transaction's merchant"
    field(:get_transaction_merchant, :merchant) do
      arg(:id, non_null(:id))

      resolve(&TransactionsResolver.get_transaction_merchant/3)
    end

    @desc "find transactions by description"
    field(:find_transactions_by_description, :user) do
      arg(:description, non_null(:string))

      resolve(&TransactionsResolver.find_transactions_by_description/1)
    end

    @desc "find transactions by amount"
    field(:find_transactions_by_amount, :user) do
      arg(:amount, non_null(:integer))

      resolve(&TransactionsResolver.find_transactions_by_amount/2)
    end
  end

  object :transaction_mutations do
    @desc "Create a new transaction"
    field :create_transaction, :transaction do
      arg(:user_id, non_null(:id))
      arg(:merchant_id, non_null(:id))
      @desc "amount is in cents"
      arg(:amount, non_null(:integer))
      arg(:credit, non_null(:boolean))
      arg(:debit, non_null(:boolean))
      arg(:description, non_null(:string))

      resolve(&TransactionsResolver.create_transaction/3)
    end

    @desc "Update a new transaction"
    field :update_transaction, :transaction do
      arg(:id, non_null(:id))
      arg(:user_id, non_null(:id))
      arg(:merchant_id, non_null(:id))
      @desc "amount is in cents"
      arg(:amount, non_null(:integer))
      arg(:credit, non_null(:boolean))
      arg(:debit, non_null(:boolean))
      arg(:description, non_null(:string))

      resolve(&TransactionsResolver.update_transaction/3)
    end

    @desc "delete an existing transaction"
    field :delete_transaction, :transaction do
      arg(:id, non_null(:id))

      resolve(&TransactionsResolver.delete_transaction/3)
    end
  end
end
