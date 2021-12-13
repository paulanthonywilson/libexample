defmodule Libexample.RealGithubClient do
  @moduledoc """
  Simple api client for Github, for example purposes only
  """
  @behaviour Libexample.GithubClient

  @httpoison Application.compile_env(:libexample, HTTPoison, HTTPoison)

  @impl true
  def list_pull_requests(config, owner, repository) do
    user = Keyword.fetch!(config, :user)
    token = Keyword.fetch!(config, :token)
    do_list_pull_requests({user, token}, owner, repository)
  end


  defp do_list_pull_requests(auth, owner, repository) do
    path = Path.join(["https://api.github.com", "repos", owner, repository, "pulls"])

    options = [hackney: [basic_auth: auth]]

    with {:ok, %{body: body, status_code: 200}} <- @httpoison.get(path, [], options),
         {:ok, responses} <- Jason.decode(body) do
      {:ok, Enum.map(responses, &deconstruct/1)}
    else
      {:ok, %HTTPoison.Response{} = resp} -> {:error, resp}
      err -> err
    end
  end

  defp deconstruct(%{"title" => title, "url" => url, "user" => %{"login" => requester}}) do
    %{title: title, url: url, requester: requester}
  end
end
