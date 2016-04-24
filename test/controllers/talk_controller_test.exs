defmodule Talks.TalkControllerTest do
  use Talks.ConnCase

  alias Talks.Talk
  @valid_attrs %{presenter: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, talk_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing talks"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, talk_path(conn, :new)
    assert html_response(conn, 200) =~ "New talk"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, talk_path(conn, :create), talk: @valid_attrs
    assert redirected_to(conn) == talk_path(conn, :index)
    assert Repo.get_by(Talk, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, talk_path(conn, :create), talk: @invalid_attrs
    assert html_response(conn, 200) =~ "New talk"
  end

  test "shows chosen resource", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = get conn, talk_path(conn, :show, talk)
    assert html_response(conn, 200) =~ "Show talk"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, talk_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = get conn, talk_path(conn, :edit, talk)
    assert html_response(conn, 200) =~ "Edit talk"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = put conn, talk_path(conn, :update, talk), talk: @valid_attrs
    assert redirected_to(conn) == talk_path(conn, :show, talk)
    assert Repo.get_by(Talk, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = put conn, talk_path(conn, :update, talk), talk: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit talk"
  end

  test "deletes chosen resource", %{conn: conn} do
    talk = Repo.insert! %Talk{}
    conn = delete conn, talk_path(conn, :delete, talk)
    assert redirected_to(conn) == talk_path(conn, :index)
    refute Repo.get(Talk, talk.id)
  end
end
