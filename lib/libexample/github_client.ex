defmodule Libexample.GithubClient do
  @moduledoc """
  Defines the behaviour for a Github client implementation
  """

  @doc """
  As per tin, uses the access token to list the pull requests for a repository
  Config is expected to have the keywords "user" and "token" corresponding to
  a personal api token and associated username.

  """
  @callback list_pull_requests(
              config :: Keyword.t(),
              owner :: String.t(),
              repository :: String.t()
            ) :: {:ok, list()} | {:error, term}
end
