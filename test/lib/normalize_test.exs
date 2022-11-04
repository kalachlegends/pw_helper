defmodule PwHelperTest.Normalize do
  use ExUnit.Case

  defstruct __meta__: "test",
            name: "",
            struct: %PwHelper.Normalize{},
            list: [%PwHelper.Normalize{}, %PwHelper.Normalize{}]

  test "test normalize repo" do
    assert PwHelper.Normalize.repo(%{}) == %{}
    assert PwHelper.Normalize.repo(%PwHelperTest.Normalize{})

    assert PwHelper.Normalize.repo(%PwHelperTest.Normalize{}) == %{
             name: "",
             struct: %{name: 12, l: 2, asdda: [123, 123_213]},
             list: [
               %{name: 12, l: 2, asdda: [123, 123_213]},
               %{name: 12, l: 2, asdda: [123, 123_213]}
             ]
           }
  end
end
