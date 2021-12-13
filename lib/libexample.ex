defmodule Libexample do
  @moduledoc """
  Documentation for `Libexample`.
  """

  defmacro __using__(opts) do
    otp_app = Keyword.fetch!(opts, :otp_app)

    quote do
      @behaviour Libexample
      def list_pull_requests(owner, repository) do
        Libexample.RealGithubClient.list_pull_requests({user(), token()}, owner, repository)
      end

      defp token, do: Keyword.fetch!(config(), :token)
      defp user, do: Keyword.fetch!(config(), :user)

      defp config do
        config = Application.fetch_env!(unquote(otp_app), __MODULE__)
      end
    end
  end

  @callback list_pull_requests(owner :: String.t(), repository :: String.t()) ::
              {:ok, list()} | {:error, term}
end
