# In a step-by-step tutorial, we will learn how to pass options into Guardian to set token type and expiration time in our REST API Tutorial. We will refactor our authorization code and clean up some nasty stuff we did in the last video. Follow along for a step-by-step tutorial to learn how to implement Guardian options, allowing us to set types and expire tokens in our Elixir REST API Tutorial.

## STEPS 
1. Go to guardian file on create token function on the encode and sign function add struct for claims 
add the following 
```
 defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account, %{}, token_options(type) )
    {:ok, account, token}
  end
  
  # When acces token is created then set it to expire after two hours
  
  defp token_options(type) do
    case type do
      :access -> [token_type: "access", ttl: {2, :hour}]
      :reset -> [token_type: "reset", ttl: {15, :minute}]
      :admin -> [token_type: "admin", ttl: {90, :day}]
    end
  end
``` 
3. Go to authenticate function add :acss on create funvtion when calling it 

4. Go to account controller to some clean ups on the create and sign in functions for them to share some code Put this code 
Creating private function thats call our authenticate part 
# Returning things of the sign in function so its the same as sign in 
```
  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
          {:ok, %User{} = _user} <- Users.create_user(account, account_params) do
      authorize_account(conn, account.email, account_params["hash_password"])
    end
  end

  def sign_in(conn, %{"email" => email, "hash_password" => hash_password}) do
    authorize_account(conn, email, hash_password)
  end

  defp authorize_account(conn, email, hash_password) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render("account_token.json", %{account: account, token: token})
      {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

```

5. Check 12 minutes on the video 

6. Go to refresh token function and make things clear and do some clean up 
  ```
   token = Guardian.Plug.current_token(conn)
    {:ok, account, new_token} = Guardian.authenticate(token)
    conn
    |> Plug.Conn.put_session(:account_id, account.id)
    |> put_status(:ok)
    |> render("account_token.json", %{account: account, token: new_token})
  ``` 

7. Go to guardian file and create new fuction below for authenticate  
   ```
   
  def authenticate(token) do
    with {:ok, claims} <- decode_and_verify(token),
         {:ok, account} <- resource_from_claims(claims),
         {:ok, _old, {new_token, _claims}} <- refresh(token) do

      {:ok, account, new_token}
    end
  end
  ```