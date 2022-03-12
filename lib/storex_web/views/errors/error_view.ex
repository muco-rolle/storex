defmodule StorexWeb.ErrorView do
  use StorexWeb, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".

  def render("400.json", %{error: reason}) do
    %{status: 400, message: reason}
  end

  def render("401.json", _assigns) do
    %{status: 401, message: "Unauthorized"}
  end

  def render("404.json", _assigns) do
    %{status: 404, message: "Ressource not found"}
  end

  def render("500.json", _assigns) do
    %{status: 500, message: "Internal Server Error"}
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
