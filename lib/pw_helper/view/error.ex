defmodule PwHelper.View.Error do
  def error_message(message) do
    cond do
      is_list(message) ->
        Enum.map(message, fn {k, v} ->
          {message, _} = v
          %{"#{k}" => message}
        end)

      is_struct(message) ->
        Enum.map(message.errors, fn {k, v} ->
          {message, _} = v
          %{"#{k}" => message}
        end)

      true ->
        message
    end

    %{status: "error", error: message}
  end
end
