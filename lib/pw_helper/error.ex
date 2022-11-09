defmodule PwHelper.Error do
  defmacro __using__(_opts) do
    quote do
      @doc """
         Check value on nil
      
         ACCCEPT throws_is_nil(value, message)
         ## Examples
      
        iex > throw_is_nil(nil, "nil")
      
        {:error, "nil"}
      
        iex > throw_is_nil(nil, "nil")
      
        :ok
      """
      def throw_is_nil(param, message \\ "parametr is empty") do
        if is_nil(param), do: throw({:error, message})
        :ok
      end

      @doc """
      Check values on nil
      
      ACCCEPT throws_is_nil(id: "var")
      ## Examples
        iex > throws_is_nil(%{map: nil, map2: nil})
      
        {:error, %{map: "is_not_nil",map2: "is_no_nil"}}
      
        iex > throws_is_nil(%{map: "!@3", map2: "!@#"})
      
        :ok
      """
      def throws_is_nil(param \\ %{}) do
        if Enum.any?(param, fn {key, value} -> is_nil(value) end) do
          error_list =
            Enum.map(param, fn {key, value} ->
              if is_nil(value) do
                {key, Atom.to_string(key) <> " parametr is empty"}
              end
            end)
            |> Enum.filter(&(!is_nil(&1)))

          throw({:error, Map.new(error_list)})
        end

        :ok
      end

      @doc """
      Accepts a function if there are no errors throw returns the execution result
      If there are still errors, return the result of the error
      
      ## Examples
        iex> func = fn x -> throw(x) end
      
        iex> return_throw(func("ERROR"))
      
        "ERROR"
      
        iex> return_throw(__MODULE__.func(params))
      
      (throw or result function)
      """
      defmacro return_throw(function) do
        quote do
          try do
            unquote(function)
          catch
            any -> any
          end
        end
      end
    end
  end
end
