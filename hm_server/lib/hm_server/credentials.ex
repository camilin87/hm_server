defmodule HMServer.Credential do
  @moduledoc """
  Credential: a single registered api account
  """

  use Ecto.Schema
  alias HMServer.Repo, as: Repo

  schema "api_credentials" do
    field :client_id, :string
    field :secret_key, :string
    field :client_disabled, :boolean

    timestamps()
  end

  def is_valid("", ""), do: false
  def is_valid("", _), do: false
  def is_valid(_, ""), do: false
  def is_valid(user, secret) do
    query = %{client_id: user, secret_key: secret, client_disabled: false}

    case HMServer.Credential |> Repo.get_by(query) do
      %HMServer.Credential{} -> true
      _ -> false
    end
  end
end
