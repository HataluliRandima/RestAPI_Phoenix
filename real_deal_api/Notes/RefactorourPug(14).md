# In a step-by-step tutorial, we'll walk you through the process of refactoring our Plug action to verify account permissions for updating specific data in our REST API project.  Our Plug action is located in the Account Controller, but we'd like to extend its use to other controllers, such as the User Controller.  We will refactor our account JSON response to include our user JSON data.  Follow along for a step-by-step tutorial to learn how to refactor our Plug to reuse in our Elixir REST API project.

# STEPS 

1. Take is autherized from the account controller and make a new file to paste that code  create a new file under auth 

```
defmodule RealDealApiWeb.Auth.AuthorizedPlug do
  
  
  defp is_authorized_account(conn, _opts) do
    %{params: %{"account" => params}} = conn
    account = Accounts.get_account!(params["id"])

    if conn.assigns.account.id == account.id do
      conn
    else
      raise ErrorResponse.Forbiden
    end
  end

end
```
2. Then go back to the account controller an dimport those things 
```
 import RealDealApiWeb.Auth.AuthrizedPlug
  
  plug :is_authorized when action in [:update, :delete]

 ```

 3. And the same at user controller  we pasted the code above 

 4. We went to authorized plug file and add some pattern match ther user staff see below 
 ```
  def is_authorized(%{params: %{"user" => params}} = conn, _opts) do

    #account = Accounts.get_account!(params["id"])
# if current session is the same with one passes
    if conn.assigns.account.user.id == params["id"] do
      conn
    else
      raise ErrorResponse.Forbiden
    end
  end
  ```

  5. Went to set account file under the auth to make some changes so that our user can be linked with accout there by the session

  ```
  account = Accounts.get_full_account(account_id)
  ```

6. On the user controller went to update method 
 we removed id as params because we will take the one from the account 
 - And instead of taking user at the database we will take the one already stored on the assigns session made some changes there 