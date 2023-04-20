defmodule HomeworkWeb.Resolvers.CompaniesResolver do
  alias Homework.Companies

  @doc """
  Get a list of companies
  """
  def companies(_root, args, _info) do
    {:ok, Companies.list_companies(args)}
  end

  @doc """
  Create a new company
  """
  def create_company(_root, %{credit_line: credit_line} = args, _info) do
    new_args = Map.put(args, :available_credit, credit_line)
    case Companies.create_company(new_args) do
      {:ok, company} ->
        {:ok, company}

      error ->
        {:error, "could not create company: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a company for an id with args specified.
  """
  def update_company(_root, %{id: id} = args, _info) do
    company = Companies.get_company!(id)

    case Companies.update_company(company, args) do
      {:ok, company} ->
        {:ok, company}

      error ->
        {:error, "could not update company: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a company for an id
  """
  def delete_company(_root, %{id: id}, _info) do
    company = Companies.get_company!(id)

    case Companies.delete_company(company) do
      {:ok, company} ->
        {:ok, company}

      error ->
        {:error, "could not update company: #{inspect(error)}"}
    end
  end

  def get_company_users(_root,  %{id: id}, _info) do
    case Companies.get_company_users(id) do
      {:ok, users} ->
        {:ok, users}

      error ->
        {:error, "could not find company's users: #{inspect(error)}"}
    end
  end

  def get_company_transactions(_root, %{id: id}, _info) do
    case Companies.get_company_transactions(id) do
      {:ok, transactions} ->
        {:ok, transactions}

      error ->
        {:error, "could not find company's transactions: #{inspect(error)}"}
    end
  end
end
