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

    map = %{
      user: %{
        __meta__: 123,
        __struct__: Auth.Model.User,
        data: %{"img" => "", "name" => ""},
        email: "login@",
        id: 27,
        inserted_at: ~N[2022-11-06 01:52:54],
        login: "login123",
        repassword: "login",
        updated_at: ~N[2022-11-06 01:52:54]
      },
      token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJKb2tlbiIsImV4cCI6MTY2NzcwMzE3NCwiaWF0IjoxNjY3Njk5NTc0LCJpc3MiOiJKb2tlbiIsImp0aSI6IjJzaWRucmI5NHA2dWNkNjNnODAwMDB1OCIsIm5iZiI6MTY2NzY5OTU3NCwidXNlcl9pZCI6Mjd9.mZItLyoAWMvhnfRP88R5XbmEoeiEXvdseVN91QX1MCs"
    }

    assert PwHelper.Normalize.repo(map)
  end
end
