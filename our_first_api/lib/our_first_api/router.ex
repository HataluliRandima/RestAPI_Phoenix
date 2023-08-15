defmodule OurFirstApi.Router do
  # From cowboy dependencies
  use Plug.Router
  # To log or see incoming request in our shell use this
  plug(Plug.Logger)
  #it tells our plug to match incoming request to our defined endpoints.
  plug(:match)
  # if there is match up there then we pass the response bosy
  # Down there if the the content typr is application/json
  plug(Plug.Parsers,
  parsers: [:json],
  pass: ["application/json"],
  json_decoder: Jason
  )
  #it dispatches the connection to the matched handler
  plug(:dispatch)




 # HANDLERS
  get "/", do: send_resp(conn, 200, "OK")

  get "/name", do: send_resp(conn, 200, "Mr Genny")


  #FAllback handler to catch all errors that will come through
  # For any endpoints that doent exist
  match _, do: send_resp(conn, 404, "Not found")



end
