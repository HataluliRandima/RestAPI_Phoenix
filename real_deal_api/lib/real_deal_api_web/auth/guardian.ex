defmodule RealDealApiWeb.Auth.Guardian do
  # use this to decode and encode tokens
  use Guardian, otp_app: :real_deal_api

  alias RealDealApi.Accounts # access to account context file where we do those query to database


  # passing json with an id
  def subject_for_token(%{id: id}, _claims) do
   # converting id to string
    sub = to_string(id)
    {:ok, sub}
  end

  # same function for having empty json and no claims
  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    # we going to use account in in our token

    case Accounts.get_account!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  # for empty staff to give an error
  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil -> {:error, unauthored}
      account ->
    end
  end
end
