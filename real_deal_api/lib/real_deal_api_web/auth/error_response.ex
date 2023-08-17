defmodule RealDealApiWeb.Auth.ErrorResponse.Unauthorized do

    defexception [message: "Unauthorized", plug_status: 401]

end


defmodule RealDealApiWeb.Auth.ErrorResponse.Forbidden do
  defexception [message: "you dont have access", plug_status: 403]
end

# video 11
defmodule RealDealApiWeb.Auth.ErrorResponse.NotFound do
  defexception [message: "Not Found", plug_status: 404]
end
