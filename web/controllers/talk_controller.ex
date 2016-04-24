defmodule Talks.TalkController do
  use Talks.Web, :controller

  alias Talks.Talk

  plug :scrub_params, "talk" when action in [:create, :update]

  def index(conn, _params) do
    talks = Repo.all(Talk)
    render(conn, "index.html", talks: talks)
  end

  def new(conn, _params) do
    changeset = Talk.changeset(%Talk{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"talk" => talk_params}) do
    changeset = Talk.changeset(%Talk{}, talk_params)

    case Repo.insert(changeset) do
      {:ok, _talk} ->
        conn
        |> put_flash(:info, "Talk created successfully.")
        |> redirect(to: talk_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    talk = Repo.get!(Talk, id)
    render(conn, "show.html", talk: talk)
  end

  def edit(conn, %{"id" => id}) do
    talk = Repo.get!(Talk, id)
    changeset = Talk.changeset(talk)
    render(conn, "edit.html", talk: talk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "talk" => talk_params}) do
    talk = Repo.get!(Talk, id)
    changeset = Talk.changeset(talk, talk_params)

    case Repo.update(changeset) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk updated successfully.")
        |> redirect(to: talk_path(conn, :show, talk))
      {:error, changeset} ->
        render(conn, "edit.html", talk: talk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    talk = Repo.get!(Talk, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(talk)

    conn
    |> put_flash(:info, "Talk deleted successfully.")
    |> redirect(to: talk_path(conn, :index))
  end
end
