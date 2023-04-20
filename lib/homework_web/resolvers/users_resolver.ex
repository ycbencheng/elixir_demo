defmodule HomeworkWeb.Resolvers.UsersResolver do
  alias Homework.Users

  @doc """
  Get a list of users
  """
  def users(_root, args, _info) do
    {:ok, Users.list_users(args)}
  end

  @doc """
  Creates a user
  """
  def create_user(_root, args, _info) do
    case Users.create_user(args) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not create user: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a user for an id with args specified.
  """
  def update_user(_root, %{id: id} = args, _info) do
    user = Users.get_user!(id)

    case Users.update_user(user, args) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not update user: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a user for an id
  """
  def delete_user(_root, %{id: id}, _info) do
    user = Users.get_user!(id)

    case Users.delete_user(user) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not update user: #{inspect(error)}"}
    end
  end

  def get_user_company(_root, %{id: id}, _info) do
    case Users.get_user_company(id) do
      {:ok, company} ->
        {:ok, company}

      error ->
        {:error, "could not find user's company: #{inspect(error)}"}
    end
  end

  def get_user_transactions(_root, %{id: id}, _info) do
    case Users.get_user_transactions(id) do
      {:ok, transactions} ->
        {:ok, transactions}

      error ->
        {:error, "could not find user's transactions: #{inspect(error)}"}
    end
  end

  def find_users_by_name(first_name, last_name) do
    case Users.find_users_by_name(first_name, last_name) do
      {:ok, users} ->
        {:ok, users}

      error ->
        {:error, "could not find any users: #{inspect(error)}"}
    end
  end
end
