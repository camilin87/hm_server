defmodule HMServerWeb.ApiStatusControllerTest do
  use HMServerWeb.ConnCase
  alias HMServer.Repo, as: Repo

  test "GET /api/status returns ok", %{conn: conn} do
    Cachex.clear(:api_cache)

    conn = get conn, "/api/status"

    assert true == json_response(conn, 200)["success"]
  end

  test "GET /api/status returns not ok the db is not online", %{conn: conn} do
    Cachex.clear(:api_cache)
    HMServer.Status
    |> Repo.delete_all

    conn = get conn, "/api/status"

    assert false == json_response(conn, 503)["success"]
  end
end
