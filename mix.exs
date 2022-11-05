defmodule PwHelper.MixProject do
  use Mix.Project

  def project do
    [
      app: :pw_helper,
      version: "0.1.0",
      elixir: "~> 1.12.2",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.6"}
    ]
  end
end
