defmodule Mix.Tasks.SonarSweep do
  @moduledoc """
  First challenge: sonar sweep.

  Usage:

      mix sonar_sweep ./data/sonar_sweep.txt

  """
  use Mix.Task

  def run([path | _]) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim_trailing(&1, "\n"))
    |> Stream.map(&String.to_integer/1)
    |> Stream.chunk_every(3, 1)
    |> Stream.map(&Enum.sum/1)
    |> Enum.reduce({0, nil}, &sonar_counter/2)
    |> display_result()
  end

  defp display_result({counter, _last_value}) do
    Mix.shell().info("Result: #{counter}")
  end

  defp sonar_counter(value, {acc, last_value}) do
    if value > last_value do
      {acc + 1, value}
    else
      {acc, value}
    end
  end
end
