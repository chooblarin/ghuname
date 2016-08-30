defmodule Ghuname.GithubUsername do

  @user_agent [{"user-agent", "https://github.com/chooblarin/ghuname"}]

  def search_url(email) do
    "https://api.github.com/search/users?q=#{email}"
  end

  def fetch(email) do
    search_url(email)
    |> HTTPoison.get(@user_agent)
  end
end
