defmodule Example.PrLister do
  use Libexample, otp_app: :example

  def count(owner, repo) do
    with {:ok, prs} <- list_pull_requests(owner, repo) do
      {:ok, length(prs)}
    end
  end
end
