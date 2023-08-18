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
          true -> create_token(account, :access)
          false -> {:error, :unauthorized}
        end
    end
  end

  # another function

  def authenticate(token) do
    with {:ok, claims} <- decode_and_verify(token),
         {:ok, account} <- resource_from_claims(claims),
         {:ok, _old, {new_token, _claims}} <- refresh(token) do

      {:ok, account, new_token}
    end
  end

  def validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  # function to generate our token
  defp create_token(account, type) do
    {:ok, token, _claims} = encode_and_sign(account, %{}, token_options(type) )
    {:ok, account, token}
  end

  # Helper function to help us for token options
  defp token_options(type) do
    case type do
      :access -> [token_type: "access", ttl: {2, :hour}]
      :reset -> [token_type: "reset", ttl: {15, :minute}]
      :admin -> [token_type: "admin", ttl: {90, :day}]
    end
  end

  # The functions below are the ovverides

  def after_encode_and_sign(resource, claims, token, _options) do
    with {:ok, _} <- Guardian.DB.after_encode_and_sign(resource, claims["typ"], claims, token) do
      {:ok, token}
    end
  end

  def on_verify(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_verify(claims, token) do
      {:ok, claims}
    end
  end
  # video 11
   def on_refresh({old_token, old_claims}, {new_token, new_claims}, _options) do
     with {:ok, _, _} <- Guardian.DB.on_refresh({old_token, old_claims}, {new_token, new_claims}) do
      {:ok, {old_token, old_claims}, {new_token, new_claims}}
     end
   end

  def on_revoke(claims, token, _options) do
    with {:ok, _} <- Guardian.DB.on_revoke(claims, token) do
      {:ok, claims}
    end
  end
end
