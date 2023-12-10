defmodule PwHelper.Normalize do
  @moduledoc false
  require Decimal
  defstruct name: 12, l: 2, __meta__: 123, asdda: [123, 123_213]

  @doc """
  # Normalize for repo struct

  Change time and make struct to map
  """
  def repo(repo) do
    cond do
      is_struct(repo) -> normalize_repo(repo)
      is_map(repo) -> normalize_repo(repo)
      is_list(repo) -> nomalize_list_for_repo(repo)
      true -> repo
    end
  end

  def normalize_repo(struct) do
    cond do
      Keyword.keyword?(struct) -> normalize_repo(struct, :normalize)
      is_struct(struct) -> normalize_map(struct) |> normalize_repo(:normalize)
      is_map(struct) -> normalize_map(struct, :map) |> normalize_repo(:normalize)
      true -> struct
    end
  end

  defp normalize_repo(struct, :normalize) do
    Enum.map(struct, fn {key, value} ->
      cond do
        is_struct(value) and check_time(value) ->
          {key, time_to_string(value)}

        is_struct(value) and native_check_time(value) ->
          {key, time_to_string(value)}

        is_struct(value) and check_time(value) ->
          {key, time_to_string(value)}

        Decimal.is_decimal(value) ->
          Decimal.to_float(value)

        is_struct(value) and check_utc(value) ->
          {key, time_to_string(value)}

        value == nil ->
          {key, nil}

        is_struct(value) and !check_assoction(value) ->
          {key, normalize_repo(value)}

        check_assoction(value) ->
          {key, nil}

        is_list(value) ->
          {key, nomalize_list_for_repo(value)}

        is_tuple(value) ->
          {key, turple_normalize(value)}

        is_map(value) ->
          {key, normalize_repo(value)}

        true ->
          {key, value}
      end
    end)
    |> Map.new()
  end

  def time_to_string(time) do
    time |> NaiveDateTime.to_iso8601()
  end

  def turple_normalize(turple) when is_tuple(turple) do
    Tuple.to_list(turple) |> Enum.join(",")
  end

  def normalize_map(struct) do
    struct
    |> Map.from_struct()
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
  end

  def normalize_map(struct, :map) do
    struct
    |> Map.delete(:__meta__)
    |> Map.delete(:__struct__)
  end

  def nomalize_list_for_repo(list) when is_list(list) do
    cond do
      list != [] -> list |> Enum.map(fn x -> normalize_repo(x) end)
      true -> list
    end
  end

  defp check_time(_time = %Time{}), do: true

  defp check_time(_time), do: false

  defp native_check_time(_time = %NaiveDateTime{}), do: true

  def check_utc(_time = %DateTime{}), do: true

  def check_utc(_time), do: false

  defp native_check_time(_time), do: false

  def check_assoction(_assoc = %Ecto.Association.NotLoaded{}) do
    true
  end

  def check_assoction(_assoc), do: false
end
