# In a step-by-step tutorial, we will learn how to use Ecto Preload to query the user association with our account data in our REST API Tutorial. We will refactor our account JSON response to include our user JSON data. Follow along for a step-by-step tutorial to learn how to implement Ecto Preload in our Elixir REST API Tutorial.

1. Using Ecto preload to fetch our user data and return it as an embedded map with our account struct.

2. Has_one relationships it allows us to use ecto preload 

# STEPS 

1. Go to your accounts context file, add new account called this below 
```
  def get_full_account(id) do
    Account # our scema file
    |> where(id: ^id)
    # basically is for returning user data wtogether with account  
    |> preload([:user]) # this bcs of the relationship between the two 
    |> Repo.one()
  end
```

2. GO to account json view to maker some changes so that we can render user data 
- add these function and remove hashed password bcs fronent
```
  alias RealDealApiWeb.AccountJSON
  alias RealDealApiWeb.UserJSON
  
  def show_fullaccount(%{account: account}) do
    %{
      id: account.id,
      email: account.email,
      hash_password: account.hash_password
    }
  end
  ```

  3. Call the get full account function on the controller the by show method and again on the render part call that function you created on the view which is show_fullaccount to render the page 

  4. SOlve the bug 