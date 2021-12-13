import Config

config :example, Example.PrLister,
  user: System.fetch_env!("GITHUB_USER"),
  token: System.fetch_env!("GITHUB_TOKEN")
