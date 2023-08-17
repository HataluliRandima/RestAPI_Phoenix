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