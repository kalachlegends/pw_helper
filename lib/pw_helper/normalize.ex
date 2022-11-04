defmodule PwHelper.Normalize do
  @moduledoc false
  defstruct name: 12, l: 2, __meta__: 123, asdda: [123, 123_213]

  @doc """
  
  """
  def repo(repo) do
    cond do
      is_struct(repo) -> normalize_repo(repo)
      is_list(repo) -> nomalize_list_for_repo(repo)
      true -> repo
    end
  end

  def normalize_repo(struct) do
    cond do
      Keyword.keyword?(struct) -> normalize_repo(struct, :normalize)
      is_struct(struct) -> normalize_map(struct) |> normalize_repo(:normalize)
      is_map(struct) -> normalize_repo(:normalize)
      true -> struct
    end
  end

  defp normalize_repo(struct, :normalize) do
    Enum.map(struct, fn {key, value} ->
      cond do
        is_struct(value) ->
          {key, normalize_repo(value)}

        is_list(value) ->
          {key, nomalize_list_for_repo(value)}

        is_atom(value) ->
          {key, Atom.to_string(value)}

        true ->
          {key, value}
      end
    end)
    |> Map.new()
  end

  def normalize_map(struct) do
    struct
    |> Map.from_struct()
    |> Map.delete(:__meta__)
  end

  def nomalize_list_for_repo(list) when is_list(list) do
    cond do
      list != [] -> list |> Enum.map(fn x -> normalize_repo(x) end)
      true -> list
    end
  end
end