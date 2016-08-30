defmodule Ghuname.GithubUsername do

  @user_agent [{"user-agent", "https://github.com/chooblarin/ghuname"}]

  def search_url(email) do
    "https://api.github.com/search/users?q=#{email}"
  end

  def fetch(email) do
    search_url(email)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, Poison.Parser.parse!(body)}
  end

  def handle_response({_, %{status_code: _, body: body}}) do
    {:error, Poison.Parser.parse!(body)}
  end
end
