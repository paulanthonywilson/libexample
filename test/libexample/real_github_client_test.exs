defmodule Libexample.RealGithubClientTest do
  use ExUnit.Case

  alias Libexample.RealGithubClient
  import Mox

  setup :verify_on_exit!

  test "url, parameters, and options sent to Github" do
    Mox.expect(MockHTTPoison, :get, fn request, _headers, options ->
      assert request == "https://api.github.com/repos/mavis/things/pulls"
      assert options == [hackney: [basic_auth: {"bob", "token"}]]

      {:ok, %HTTPoison.Response{status_code: 200, body: Jason.encode!([])}}
    end)

    RealGithubClient.list_pull_requests({"bob", "token"}, "mavis", "things")
  end

  test "returning prs" do
    Mox.stub(MockHTTPoison, :get, fn _, _, _ ->
      repos = [
        %{url: "http://github/somepr1", title: "pr 1", user: %{login: "rita"}},
        %{url: "http://github/somepr2", title: "pr 2", user: %{login: "sue"}}
      ]

      {:ok, %HTTPoison.Response{status_code: 200, body: Jason.encode!(repos)}}
    end)

    assert {:ok,
            [
              %{requester: "rita", title: "pr 1", url: "http://github/somepr1"},
              %{requester: "sue", title: "pr 2", url: "http://github/somepr2"}
            ]} == RealGithubClient.list_pull_requests({"bob", "token"}, "mavis", "things")
  end

  test "wrong status" do
    Mox.stub(MockHTTPoison, :get, fn _, _, _ ->
      {:ok, %HTTPoison.Response{status_code: 404, body: "dunnolol"}}
    end)

    assert {:error, %{status_code: 404}} =
      RealGithubClient.list_pull_requests({"", ""}, "mavis", "things")
  end
end
