# UML Diagram
- Two classes User and account (schemas)
- Do it using draw.io

# Generating Context / schemas / models
- using this command it generates controller, view and context for json resources for Account table
- Accounts module(prulal) / Context file, Schema file (singular)and table name on db(prural)
   $ mix phx.gen.json Accounts Account accounts email:string

- create user schema 
  $ mix phx.gen.json Users User users account_id:references:accounts full_name:string gender:string biography:text