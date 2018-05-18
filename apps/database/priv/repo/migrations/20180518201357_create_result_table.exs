defmodule FootballResults.Repo.Migrations.CreateResultTable do
  use Ecto.Migration

  def change do
    create table(:result, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :division, :string
      add :season, :string
      add :date, :date
      add :home_team, :string
      add :away_team, :string
      add :fthg, :integer
      add :ftag, :integer
      add :ftr, :string
      add :hthg, :integer
      add :htag, :integer
      add :htr, :string
    end
  end
end
