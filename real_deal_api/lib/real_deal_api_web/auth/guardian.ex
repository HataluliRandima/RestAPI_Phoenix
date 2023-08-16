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

  # use this to login or to get our token
  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil -> {:error, :unauthored}
      account ->
        case validate_password(password,account.hash_password) do
          true -> create_token(account)
          false -> {:error, :unauthorized}
        end
    end
  end

  defp validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  # function to generate our token
  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account)
    {:ok, account, token}
  end

end
