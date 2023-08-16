# UML Diagram
- Two classes User and account (schemas)
- Do it using draw.io

# Generating Context / schemas / models
- using this command it generates controller, view and context for json resources for Account table
- Accounts module(prulal) / Context file, Schema file (singular)and table name on db(prural)
   $ mix phx.gen.json Accounts Account accounts email:string

- create user schema 
  $ mix phx.gen.json Users User users account_id:references:accounts full_name:string gender:string biography:text

 # On migrations 
   create unique_index(:accounts, [:email])
   - So creating index its create one of the values in our table here its email.
   - It allows us to search by that variable
   - And it wont allow duplicate values for this variable no multiple accounts of the same email

# changeset(account, attrs) Function 
- is called to create our object before persists into the database and also it allows us to do all sorts of validations checks here.\

- Check cast meaning 

- For this we created two schemas and connected them with databases  and done some migration on creating tables and databses 