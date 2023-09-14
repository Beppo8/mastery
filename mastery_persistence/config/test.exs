use Mix.Config

config :mastery_persistence, MasteryPersistence.Repo,
  username: "postgres",
  password: "postgres",
  database: "mastery_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sanbox
