defmodule RealDealApiWeb.Auth.AuthorizedPlug do
  alias RealDealApiWeb.Auth.ErrorResponse

  def is_authorized(%{params: %{"account" => params}} = conn, _opts) do

    #account = Accounts.get_account!(params["id"])
# if current session is the same with one passes
    if conn.assigns.account.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbiden
    end
  end


  def is_authorized(%{params: %{"user" => params}} = conn, _opts) do

    #account = Accounts.get_account!(params["id"])
# if current session is the same with one passes
    if conn.assigns.account.user.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbiden
    end
  end

end
