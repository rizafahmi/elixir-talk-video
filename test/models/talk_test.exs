defmodule Talks.TalkTest do
  use Talks.ModelCase

  alias Talks.Talk

  @valid_attrs %{presenter: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Talk.changeset(%Talk{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Talk.changeset(%Talk{}, @invalid_attrs)
    refute changeset.valid?
  end
end
