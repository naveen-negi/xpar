# Xpar
An Elixir project to get pairing matrix for your team

Currently it supports three endpoints:
1) http://localhost:4000/api/teams/:team_id/members : this endpint is used to configure team member names, xpar 
will try to look for these names in commit message.

2) http://localhost:4000/api/teams/:team_id/repos : this endpoint is used to configure all of the repositories from which commit messages are to be read for a given team.
3) http://localhost:4000/api/teams/knav/pairing-matrix : this endpoint is used to retrieve pairing information for above configured team members and repositories.


Example:
I have added sample project in bitbucket named as "pairing-demo" for user "knav", you can play around with application by providing following data:

Add team members:

POST http://localhost:4000/api/teams/knav/members
BODY: 
    {
      "id": "knav",
      "members": ["naveen","naveen1","naveen2","naveen3", "naveen4","rin", "alex"]
     }
     
Add Repositores to watch for commits

POST: http://localhost:4000/api/teams/knav/repos
{
"id": "knav",
"repos": ["pairing-demo"]
}

Get pairing matrix
GET: http://localhost:4000/api/teams/knav/pairing-matrix
Response: 
[
    {
        "percent": 20,
        "pair": {
            "second": "naveen2",
            "first": "naveen"
        },
        "days_paired": 1
    },
    {
        "percent": 40,
        "pair": {
            "second": "naveen3",
            "first": "naveen1"
        },
        "days_paired": 2
    },
    {
        "percent": 20,
        "pair": {
            "second": "naveen4",
            "first": "naveen3"
        },
        "days_paired": 1
    },
    {
        "percent": 20,
        "pair": {
            "second": "alex",
            "first": "rin"
        },
        "days_paired": 1
    }
]

You can also view Paring matrix after starting application, currently  and then go to http://localhost4000/ in  your browser. Currently home page is naivly designed and needs further (a lot) improvement.

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
