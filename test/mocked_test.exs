defmodule Libexample.MockedTest do
  use ExUnit.Case, async: true
  use Libexample, otp_app: :libexample
  import Mox

  setup :verify_on_exit!

  setup do
    defmock(MockGithubClient, for: Libexample.GithubClient)
    :ok
  end

  test "mocking Libexample" do
    expected_config = Application.fetch_env!(:libexample, __MODULE__)

    expect(MockGithubClient, :list_pull_requests, fn config, owner, repo ->
      assert owner == "boss"
      assert repo == "hooray"
      assert config == expected_config
      {:ok, []}
    end)

    list_pull_requests("boss", "hooray")
  end
end
