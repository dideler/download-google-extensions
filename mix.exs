defmodule DownloadGoogleExtensions.Mixfile do
  use Mix.Project

  def project do
    [
      app: :download_google_extensions,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      escript: escript(),
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
    []
  end

  defp escript do
    [
      main_module: DownloadGoogleExtensions.CLI
    ]
  end
end
