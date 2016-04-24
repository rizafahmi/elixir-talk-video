defmodule Talks.Repo.Migrations.CreateTalk do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :title, :string
      add :presenter, :string

      timestamps
    end

  end
end
