defmodule ExAws.CodeBuild.MixProject do
  use Mix.Project

  @version "0.1.0"
  @service "codebuild"
  @url "https://github.com/christopherlai/ex_aws_#{@service}"
  @name __MODULE__ |> Module.split() |> Enum.take(2) |> Enum.join(".")

  def project do
    [
      app: :ex_aws_codebuild,
      deps: deps(),
      docs: docs(),
      elixir: "~> 1.5",
      homepage: @url,
      name: @name,
      package: package(),
      source: @url,
      start_permanent: Mix.env() == :prod,
      version: @version
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:hackney, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      ex_aws()
    ]
  end

  defp docs do
    [
      main: @name,
      source_ref: "v#{@version}",
      source_url: @url,
      extras: ["README.md"]
    ]
  end

  defp package do
    [
      description: "#{@name} service package",
      files: ["lib", "config", "mix.exs", "README*"],
      maintainers: ["Christopher Lai"],
      licenses: ["MIT"],
      links: %{github: @url}
    ]
  end

  defp ex_aws() do
    case System.get_env("AWS") do
      "LOCAL" -> {:ex_aws, path: "../ex_aws"}
      _ -> {:ex_aws, "~> 2.0"}
    end
  end
end
