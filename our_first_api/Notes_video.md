# First Endpoint in Elixir

- REST API was created by a computer scientist by the name, Roy Fielding.
- An API is a mechanism that enables an application or service to access a resource within another application or service.
- The application or service doing the accessing is called the client
- The application or service containing the resource is called the server
- sup flag (mix new project_name --sup): creates our application with a supervision tree
- plug_cowboy: a module composed of two modules(plug module(gives us tools to work with HTTP requests) and cowboy module(a web server written in Erlang that handles all connections and processes any incoming and outgoing requests))
JASON: super fast JSON parser and generator which we will use to handle our JSON
plug():match) : match incoming requests to defined endpoints

plug cowboy is a module composed of two modules 
it has plug module and cowboy module 
plug -- gives us tools to work with HTTP requests (like building routers and endpoints set in status code and body parsing but it doent know how to handle connections )
cowboy -- is a web server written in Erlang that handles all connections and processes any incoming and outgoing requests.


plug_cowboy - This module is composed of two other different modules Plug and Cowboy. Plug gives us tools to work with HTTP requests, like building routers and endpoints, setting status code, body parsing, etc., but it does not know how to handle connections. This is where Cowboy comes into the picture. It is a web server, written in Erlang (not Elixir), that handles all the connections and processes any incoming and outgoing request.  Both Plug & Cowboy together provide a simple framework like express.js.
jason- It is a super-fast JSON parser and generator which we will use to handle JSON. This is similar to the body-parser middleware in express.

Jason: is a sper fast json parser and generator which we will use to handle our json.

STEPS 

1. create router.ex file
   - Then put plugs on scope on router file
        (use Plug.Router ) we installed it using that dependency with plug cowboy.

        order matters
