defmodule Libexample do
  @moduledoc """

  Implements this module with `Kernel.use/2`

  Usage:

  ```
  defmodule MyApp.MyModule do
    use Libexample, otp_app: :my_app
  end
  ```
  """

  defmacro __using__(opts) do
    otp_app = Keyword.fetch!(opts, :otp_app)

    quote do
      @behaviour Libexample
      def list_pull_requests(owner, repository) do
        implementing().list_pull_requests(config(), owner, repository)
      end

      defp config do
        config = Application.fetch_env!(unquote(otp_app), __MODULE__)
      end

      defp implementing do
        Keyword.get(config(), :implementing_module, Libexample.RealGithubClient)
      end
    end
  end

  @callback list_pull_requests(owner :: String.t(), repository :: String.t()) ::
              {:ok, list()} | {:error, term}
end
