defmodule MyAppWebWeb.UserController do
  use MyAppWebWeb, :controller

  alias MyAppWeb.Accounts
  #alias MyAppWeb.Accounts.User

  action_fallback MyAppWebWeb.FallbackController
  use PhoenixSwagger
  def swagger_definitions do
    %{
      User:
        swagger_schema do
          title("User")
          description("A user of the application")

          properties do
            name(:string, "name", required: true)
            age(:string, "user age", required: true)
          end
        end
    }
  end

  swagger_path :index do
    post "/api/users"
    summary "Query for users"
  description "Query for users. This operation supports with paging and filtering"
  produces "application/json"
  tag "Users"
  operation_id "list_users"
  paging
  parameters do
    org_id :path, :string, "Organization ID", required: true
    zipcode :query, :string, "Address Zip Code", required: true, example: "90210"
    include :query, :array, "Related resources to include in response",
              items: [type: :string, enum: [:organisation, :favourites, :purchases]],
              collectionFormat: :csv
  end
  response 201, "OK"
  response 200, "OK", Schema.ref(:User)
  response 400, "Client Error"
  response 500, "Server Error"
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end
end
