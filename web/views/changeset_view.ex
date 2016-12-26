defmodule Giji.ChangesetView do
  use Giji.Web, :view

  @moduledoc """
    json for error
  """

  def translate_errors(nil) do
    %{data: ["not found."]}
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset, at: at}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: translate_errors(changeset)}
  end
end
