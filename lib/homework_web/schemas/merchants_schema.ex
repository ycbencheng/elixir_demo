defmodule HomeworkWeb.Schemas.MerchantsSchema do
  @moduledoc """
  Defines the graphql schema for merchants.
  """
  use Absinthe.Schema.Notation

  alias HomeworkWeb.Resolvers.MerchantsResolver

  object :merchant do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:description, :string)
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)

    @desc "get merchant's transactions"
    field(:get_merchant_transactions, :transaction) do
      arg(:id, non_null(:id))

      resolve(&MerchantsResolver.get_merchant_transactions/3)
    end

    @desc "find merchant by name"
    field(:find_merchants_by_name, :merchant) do
      arg(:name, non_null(:string))

      resolve(&MerchantsResolver.find_merchants_by_name/1)
    end
  end

  object :merchant_mutations do
    @desc "Create a new merchant"
    field :create_merchant, :merchant do
      arg(:name, non_null(:string))
      arg(:description, non_null(:string))

      resolve(&MerchantsResolver.create_merchant/3)
    end

    @desc "Update a new merchant"
    field :update_merchant, :merchant do
      arg(:id, non_null(:id))
      arg(:name, non_null(:string))
      arg(:description, non_null(:string))

      resolve(&MerchantsResolver.update_merchant/3)
    end

    @desc "delete an existing merchant"
    field :delete_merchant, :merchant do
      arg(:id, non_null(:id))

      resolve(&MerchantsResolver.delete_merchant/3)
    end
  end
end
