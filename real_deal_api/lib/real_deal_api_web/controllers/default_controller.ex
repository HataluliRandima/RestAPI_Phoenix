defmodule RealDealApiWeb.DefaultController do
 use RealDealApiWeb, :controller # importing from this meth/func


 def index(conn, _params) do
  text conn, "Hello , The real deal Api is live -#{Mix.env()}"
 end


end
