defmodule RealDealApiWeb.Auth.ErrorResponse.Unauthorized do

    defexception [message: "Unauthorized", plug_status: 401]

end


defmodule RealDealApiWeb.Auth.ErrorResponse.Forbidden do
  defexception [message: "you dont have access", plug_status: 403]
end
