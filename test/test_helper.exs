ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Talks.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Talks.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Talks.Repo)

