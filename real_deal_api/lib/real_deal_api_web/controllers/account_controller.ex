defmodule RealDealApiWeb.AccountController do
  use RealDealApiWeb, :controller

  alias RealDealApi.Accounts
  alias RealDealApi.Accounts.Account

  alias RealDealApi.Users
  alias RealDealApi.Users.User

  alias RealDealApiWeb.Auth.Guardian
  alias RealDealApiWeb.Auth.ErrorResponse


 # import RealDealApiWeb.Auth.AuthrizedPlug
  import RealDealApiWeb.Auth.AuthorizedPlug

  plug :is_authorized when action in [:update, :delete]

  action_fallback RealDealApiWeb.FallbackController



  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  # Crerating or regestering account
  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
        # Remove it because we are using it on the guardian file  {:ok, token, _claims} <- Guardian.encode_and_sign(account),
         {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
          authorize_account(conn, account.email, account_params["hash_password"])
    end
  end

  # For sign in or log in
  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    authorize_account(conn, email, hash_password)
  end


  defp authorize_account(conn, email, hash_password) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:showhata, %{account: account, token: token})
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  # video 11


  def refresh_session(conn, %{}) do
    token = Guardian.Plug.current_token(conn)
    {:ok, account, new_token} = Guardian.authenticate(token)
     conn
     |> Plug.Conn.put_session(:account_id, account.id)
     |> put_status(:ok)
     |> render(:showhata, %{account: account, token: new_token})

  end


  # For logout
  # so you dont pass it any parameters
  # we use struct for parameters
  def sign_out(conn, %{}) do
    account = conn.assigns[:account] # checking the active session we want the account  then we grabbed that account
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)
    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render(:showhata, %{account: account, token: nil}) # render our json response nolonger acctive token
  end


  def show(conn, %{"id" => id}) do
    account = Accounts.get_full_account(id)
    render(conn, :show_fullaccount, account: account)
    # conn.assigns.
  end

  def current_account(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render(:show_fullaccount, %{account: conn.assigns.account})
  end

  def update(conn, %{"current_hash" => current_hash,"account" => account_params}) do
   # No need to query on the database for this we can use other way
   # account = Accounts.get_account!(account_params["id"])

   case Guardian.validate_password(current_hash, conn.assigns.account.hash_password) do
    true ->
      {:ok, account} = Accounts.update_account(conn.assigns.account, account_params)
      render(conn, :show, account: account)

    false ->
      raise ErrorResponse.Unauthorized, message: "Password incorrect."
  end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
