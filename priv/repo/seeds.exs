# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Homework.Repo.insert!(%Homework.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Homework.Repo
alias Homework.Companies.Company
alias Homework.Merchants.Merchant
alias Homework.Transactions.Transaction
alias Homework.Users.User

# Delete exisitng data at the beginning
# The following order is to satisfy foreign key constraints
Repo.delete_all(Transaction)
Repo.delete_all(User)
Repo.delete_all(Merchant)
Repo.delete_all(Company)

defmodule Seeds do
  require Logger

  def create_companies(company) do
    Logger.info("Creating companies...")

    Repo.insert!(company)
  end


  def create_merchants(merchants) do
    Logger.info("Creating merchants...")

    Enum.map(merchants, fn (merchant) ->
      Repo.insert!(%Merchant{name: merchant.name, description: merchant.description})
    end)
  end

  def create_users(users, company) do
    Logger.info("Creating users...")

    Enum.map(users, fn (user) ->
      Repo.insert!(%User{first_name: user.first_name,
                         last_name: user.last_name,
                         dob: user.dob,
                         company_id: company.id})
    end)
  end

  def create_transactions(transactions, users, merchants) do
    Logger.info("Creating transactions...")

    datetime = NaiveDateTime.local_now();

    Enum.map(transactions, fn (transaction) ->
      amount = Enum.random(1..10) * 1000

      Repo.insert!(%Transaction{amount: amount,
                                credit: transaction.credit,
                                debit: transaction.debit,
                                description: transaction.description,
                                inserted_at: datetime,
                                user_id: get_id(users),
                                merchant_id: get_id(merchants)})
    end)
  end

  def get_id(obj) do
    Enum.random(obj).id
  end
end

original_amount = 100000000
company = %Company{name: "Justice League",
                   credit_line: original_amount,
                   available_credit: original_amount}

merchants = [
  %Merchant{name: "Big Belly Burger", description: "resturant"},
  %Merchant{name: "Wayne Enterprises", description: "tech"},
  %Merchant{name: "Daily Planet", description: "news"}
]

users = [
  %User{first_name: "Bruce", last_name: "Wayne", dob: "1915-04-17"},
  %User{first_name: "Clark", last_name: "Kent", dob: "1977-04-18"},
  %User{first_name: "Barry", last_name: "Allen", dob: "1989-03-14"}
]

transactions = [
  %Transaction{credit: true,
               debit: false,
               description: "the Belly Buster"},
  %Transaction{credit: false,
               debit: true,
               description: "Batarangs"},
  %Transaction{credit: true,
               debit: false,
               description: "T-shirt"},
  %Transaction{credit: false,
               debit: true,
               description: "Newspaper"}
]

company = Seeds.create_companies(company)

merchants = Seeds.create_merchants(merchants)

users = Seeds.create_users(users, company)

Seeds.create_transactions(transactions, users, merchants)
