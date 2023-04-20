defmodule Homework.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Homework.Repo

  alias Homework.Transactions.Transaction

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions([])
      [%Transaction{}, ...]

  """
  def list_transactions(_args) do
    Repo.all(Transaction)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  def get_transaction_user(id) do
    record = Homework.Transactions.get_transaction!(id) |> Repo.preload(:user)
    record.user
  end

  def get_transaction_company(id) do
    record = Homework.Transactions.get_transaction!(id) |> Repo.preload(:company)
    {:ok, record.company}
  end

  def get_transaction_merchant(id) do
    record = Homework.Transactions.get_transaction!(id) |> Repo.preload(:merchant)
    {:ok, record.merchant}
  end

  def find_transactions_by_description(description) do
    transactions = Homework.Repo.query("SELECT amount, credit, debit, description, inserted_at FROM transactions WHERE SIMILARITY(description, $1) > 0.1;", ["#{description}"])
    {:ok, %{transactions: elem(transactions, 1).rows}}
  end

  def find_transactions_by_amount(min, max) do
    transactions = Homework.Repo.query("SELECT * FROM transactions WHERE amount BETWEEN $1 AND $2  ;", [min, max])
    {:ok, %{transactions: elem(transactions, 1).rows}}
  end
end
