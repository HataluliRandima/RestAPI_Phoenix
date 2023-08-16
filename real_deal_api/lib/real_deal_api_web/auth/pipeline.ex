defmodule RealDealApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :real_deal_api,
  # implementation for our guardian
  module: RealDealApiWeb.Auth.Guardian,
  # some error handler
  error_handler: RealDealApiWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
