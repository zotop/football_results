defmodule Database.Result do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "result" do
    field :division, :string
    field :season, :string
    field :date, :date
    field :home_team, :string
    field :away_team, :string
    field :fthg, :integer
    field :ftag, :integer
    field :ftr, :string
    field :hthg, :integer
    field :htag, :integer
    field :htr, :string
  end

end
