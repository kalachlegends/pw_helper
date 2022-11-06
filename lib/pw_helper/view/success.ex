defmodule PwHelper.View.Success do
  def status_ok(data, data_name \\ "data") when is_bitstring(data_name) do
    Map.merge(%{"status" => "ok"}, map_normalize(data, data_name))
  end

  def status_ok(data, :no_message) do
    Map.merge(%{"status" => "ok"}, PwHelper.Normalize.repo(data))
  end

  defp map_normalize(data, data_name), do: %{"#{data_name}" => PwHelper.Normalize.repo(data)}

  @doc """
  ACCEPT KEYWORD OR MAP [key: value]
  """
  def message_list(data_list, map_taker \\ [], take_it \\ []) do
    data_list
    |> PwHelper.Normalize.repo()
    |> Enum.map(fn {key, value} ->
      cond do
        is_map(value) ->
          finder = Enum.find(map_taker, fn x -> x == key end)

          if !is_nil(finder) do
            {key, Map.take(value, take_it)}
          else
            {key, value}
          end

        true ->
          {key, value}
      end
    end)
    |> Map.new()
    |> status_ok(:no_message)
  end
end
