# 2. Using Phoenix Framework to Create an Elixir REST API Project
## Phoenix 
- is a web development framework thats written in Elixir, which implempents Server side model view controller (MVC) pattern.\

 ### Step 1 
mix phx.new real_deal_api --no-install --app real_deal_api --database postgres --no-live --no-assets --no-html --no-dashboard --no-mailer --binary-id

## We are almost there! The following steps are missing:

    $ cd real_deal_api
    $ mix deps.get

## Then configure your database in config/dev.exs and run:

    $ mix ecto.create

## Start your Phoenix app with:

    $ mix phx.server

## You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server