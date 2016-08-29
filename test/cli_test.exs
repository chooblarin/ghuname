defmodule CliTest do
  use ExUnit.Case

  import Ghuname.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "hoge"]) == :help
    assert parse_args(["--help", "fuga"]) == :help
  end

  test "appropriate values returned" do
    assert parse_args(["email", "token"]) == { "email", "token" }
    assert parse_args(["email"])          == { "email" }
  end
end
