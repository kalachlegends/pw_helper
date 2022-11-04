defmodule PwHelper.Hash do
  def hash(string), do: :crypto.hash(:md5, string) |> Base.encode16()

  def hash(string, method), do: :crypto.hash(method, string) |> Base.encode16()
end
