defmodule HomeworkWeb.AvailableCreditJob do
  alias Homework.Companies

  def run do
    companies = Companies.list_companies() |> Homework.Repo.preload(:transactions)

    Enum.each(companies, fn (company) ->
      transactions = company.transactions

      total_amount = Enum.reduce(transactions, 0, fn %{amount: amount}, acc -> acc + amount end)

      available_credit = company.credit_line - total_amount

      Companies.update_company(company, %{available_credit: available_credit})
    end)
  end
end
