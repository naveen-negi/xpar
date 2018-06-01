use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :xpar, XparWeb.Endpoint,
  secret_key_base: "aCA26vJZzUBb4xS6pU2jpwBfwbeqTUigyqyYnUNPPSNOntqRiYW317f/hHo3GUJi",
  http: [port: System.get_env("PORT") || 8080]

config :xpar, base_url: "https://FBAM39Q:2Y8CHa,zb7@devstack.vwgroup.com/bitbucket/rest/api/1.0/projects"

