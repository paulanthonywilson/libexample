defmodule Example.PrListerTest do
  use ExUnit.Case, async: true
  alias Example.PrLister

  import Mox

  setup :verify_on_exit!

  setup do
    defmock(MockGithubClient, for: Libexample.GithubClient)
    :ok
  end

  test "counting prs" do
    expect(MockGithubClient, :list_pull_requests, fn _, owner, repo ->
      assert owner == "bob"
      assert repo == "mavis"

      {:ok,
       [
         %{"url" => "https://whatves1"},
         %{"url" => "https://whatves2"},
         %{"url" => "https://whatves3"}
       ]}
    end)

    assert {:ok, 3} == PrLister.count("bob", "mavis")
  end
end
