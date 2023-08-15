defmodule OurFirstApi.Router do
  # From cowboy dependencies
  use Plug.Router
  # To log or see incoming request in our shell use this
  plug(Plug.Logger)
  #it tells our plug to match incoming request to our defined endpoints.
  plug(:match)

  plug(Plug.Parsers,
  parsers: [:json],
  pass: ["application/json"],
  json_decorder: Jason
  )
end
