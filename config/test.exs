use Mix.Config

config :mastery_persistence, MasteryPersistence.Repo,
  databes: "mastery_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
