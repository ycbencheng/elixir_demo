defmodule HomeworkWeb.Resolvers.TransactionsResolver do
  alias Homework.Merchants
  alias Homework.Transactions
  alias Homework.Users

  @doc """
  Get a list of transcations
  """
  def transactions(_root, args, _info) do
    {:ok, Transactions.list_transactions(args)}
  end

  @doc """
  Get the user associated with a transaction
  """
  def user(_root, _args, %{source: %{user_id: user_id}}) do
    {:ok, Users.get_user!(user_id)}
  end

  @doc """
  Get the merchant associated with a transaction
  """
  def merchant(_root, _args, %{source: %{merchant_id: merchant_id}}) do
    {:ok, Merchants.get_merchant!(merchant_id)}
  end

  @doc """
  Create a new transaction
  """
  def create_transaction(_root, args, _info) do
    case Transactions.create_transaction(args) do
      {:ok, transaction} ->
        {:ok, transaction}

      error ->
        {:error, "could not create transaction: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a transaction for an id with args specified.
  """
  def update_transaction(_root, %{id: id} = args, _info) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.update_transaction(transaction, args) do
      {:ok, transaction} ->
        {:ok, transaction}

      error ->
        {:error, "could not update transaction: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a transaction for an id
  """
  def delete_transaction(_root, %{id: id}, _info) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.delete_transaction(transaction) do
      {:ok, transaction} ->
        {:ok, transaction}

      error ->
        {:error, "could not update transaction: #{inspect(error)}"}
    end
  end

  def get_transaction_user(_root, %{id: id}, _info) do
    case Transactions.get_transaction_user(id) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not find transaction's user: #{inspect(error)}"}
    end
  end

  def get_transaction_company(_root, %{id: id}, _info) do
    case Transactions.get_transaction_company(id) do
      {:ok, company} ->
        {:ok, company}

      error ->
        {:error, "could not find transaction's company: #{inspect(error)}"}
    end
  end

  def get_transaction_merchant(_root, %{id: id}, _info) do
    case Transactions.get_transaction_merchant(id) do
      {:ok, merchant} ->
        {:ok, merchant}

      error ->
        {:error, "could not find transaction's merchant: #{inspect(error)}"}
    end
  end

  def find_transactions_by_description(description) do
    case Transactions.find_transactions_by_description(description) do
      {:ok, transactions} ->
        {:ok, transactions}

      error ->
        {:error, "could not find any transactions: #{inspect(error)}"}
    end
  end

  def find_transactions_by_amount(min, max) do
    case Transactions.find_transactions_by_amount(min, max) do
      {:ok, transactions} ->
        {:ok, transactions}

      error ->
        {:error, "could not find any transactions: #{inspect(error)}"}
    end
  end
end
