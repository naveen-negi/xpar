# Xpar
An Elixir project to get pairing matrix for your team

Currently it supports three endpoints:
1) http://localhost:4000/api/teams/:team_id/members : this endpint is used to configure team member names, xpar 
will try to look for these names in commit message.

2) http://localhost:4000/api/teams/:team_id/repos : this endpoint is used to configure all of the repositories from which commit messages are to be read for a given team.
3) http://localhost:4000/api/teams/knav/pairing-matrix : this endpoint is used to retrieve pairing information for above configured team members and repositories.

I have added sample project in bitbucket named as "pairing-demo", you can play around with application by providing following data:

POST http://localhost:4000/api/teams/knav/members
BODY: 
    {
      "id": "knav",
      "members": ["naveen","naveen1","naveen2","naveen3", "naveen4","rin", "alex"]
     }
     
POST: http://localhost:4000/api/teams/knav/repos
{
"id": "knav",
"repos": ["pairing-demo"]
}

GET: http://localhost:4000/api/teams/knav/pairing-matrix
Response: 

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
