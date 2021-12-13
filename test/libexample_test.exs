defmodule LibexampleTest do
  use ExUnit.Case, async: true
  use Libexample, otp_app: :libexample

  import Mox

  setup :verify_on_exit!

  test "gets auth from config" do
    expected_auth = Application.fetch_env!(:libexample, __MODULE__)

    token = Keyword.fetch!(expected_auth, :token)
    user = Keyword.fetch!(expected_auth, :user)

    expect(MockHTTPoison, :get, fn _, _, opts ->
      assert [hackney: [basic_auth: {user, token}]] == opts
    end)

    list_pull_requests("bob", "sixsquid")



  end

end
