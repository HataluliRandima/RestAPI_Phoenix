# In a step-by-step tutorial, we'll walk through the process of requiring our password to update our account email or password in our REST API Tutorial.  We will also create a GET request that returns our current account session without having to pass any parameters.  Follow along for a step-by-step tutorial to learn how to refactor our Account Controller in our Elixir REST API project.

# STEPS 

1. Go to the account controller and add a new variable on the update method

2. go to guardian file and we have to call our validate password method to the account controller 

3. added some changes on that function

4. Now added new function to give us current account logged in see method below
```
  def current_account(conn, %{}) do
    conn
    |> put_status(:ok)
    |> render(:show_fullaccount, %{account: conn.assigns.account})
  end
 ``` 

 5. Adde new router to see the current account 
 get "accounts/current"