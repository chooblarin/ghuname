defmodule Ghuname.CLI do

  def main(argv) do
    argv
    |> parse_args
    |> process
    |> &(IO.puts(&1))
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])
    case parse do
      { [ help: true ], _,           _ } -> :help
      { _, [ email, token ], _ } -> { email, token }
      { _, [ email ],        _ } -> { email, "no token" }
      _                                  -> :help
    end
  end

  def process({email, _token}) do
    Ghuname.GithubUsername.fetch(email)
    |> decode_response
  end

  def process(:help) do
    IO.puts "usage: ghuname <email>"
  end

  def decode_response({:ok, %{"items" => items}}) do
    case items do
      [ %{"login" => login} | _] -> login
      _ -> IO.puts "Not found"
           System.halt(2)
    end
  end

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end
end
