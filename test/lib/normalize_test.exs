defmodule PwHelperTest.View.Success do
  use ExUnit.Case

  test "test view message" do
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

    user = %{
      __meta__: 123,
      __struct__: Auth.Model.User,
      data: %{"img" => "", "name" => ""},
      email: "login@",
      id: 27,
      inserted_at: ~N[2022-11-06 01:52:54],
      login: "login123",
      repassword: "login",
      updated_at: ~N[2022-11-06 01:52:54]
    }

    assert IO.inspect(PwHelper.View.Success.status_ok(map, :no_message))
    assert PwHelper.View.Success.message_list(user)
  end
end
