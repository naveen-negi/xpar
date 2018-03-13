use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :xpar, XparWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
config :xpar, :repo_storage_file_name, :repo_test_storage
config :xpar, :members_storage_file_name, :members_test_storage
