import Config

config :libexample, HTTPoison, MockHTTPoison

config :libexample, LibexampleTest, user: "marvin", token: "marvintoken"

config :libexample, Libexample.MockedTest,
  user: "rita",
  token: "sue",
  implementing_module: MockGithubClient
