defmodule ExAws.CodeBuildTest do
  use ExUnit.Case, async: true
  alias ExAws.CodeBuild

  test "batch_delete_builds/1" do
    expected = %{"ids" => ["1", "2", "3"]}

    req = CodeBuild.batch_delete_builds(["1", "2", "3"])

    assert req.data == expected
  end

  test "batch_get_builds/1" do
    expected = %{"ids" => ["1", "2", "3"]}

    req = CodeBuild.batch_get_builds(["1", "2", "3"])

    assert req.data == expected
  end

  test "batch_get_projects/1" do
    expected = %{"names" => ["project1", "project2", "project3"]}

    req = CodeBuild.batch_get_projects(["project1", "project2", "project3"])

    assert req.data == expected
  end

  test "create_project/2" do
    expected = %{"name" => "newproject"}

    req = CodeBuild.create_project("newproject")

    assert req.data == expected
  end

  test "create_webhook/3" do
    expected = %{
      "projectName" => "project",
      "branchFilter" => "master"
    }

    req = CodeBuild.create_webhook("project", "master")

    assert req.data == expected
  end

  test "delete_project/1" do
    expected = %{"name" => "project"}

    req = CodeBuild.delete_project("project")

    assert req.data == expected
  end

  test "delete_source_credentials/1" do
    expected = %{"arn" => "arn::123"}

    req = CodeBuild.delete_source_credentials("arn::123")

    assert req.data == expected
  end

  test "delete_webhook/1" do
    expected = %{"projectName" => "project"}

    req = CodeBuild.delete_webhook("project")

    assert req.data == expected
  end

  test "import_source_credentials/4" do
    expected = %{
      "authType" => "OAUTH",
      "serverType" => "GITHUB",
      "token" => "token",
      "username" => "username"
    }

    req = CodeBuild.import_source_credentials("username", "token", "GITHUB", "OAUTH")

    assert req.data == expected
  end

  test "invalidate_project_cache/1" do
    expected = %{"projectName" => "project"}

    req = CodeBuild.invalidate_project_cache("project")

    assert req.data == expected
  end

  test "list_builds/1" do
    expected = %{}

    req = CodeBuild.list_builds()

    assert req.data == expected
  end

  test "list_builds_for_project/2" do
    expected = %{"projectName" => "project"}

    req = CodeBuild.list_builds_for_project("project")

    assert req.data == expected
  end

  test "list_curated_environment_images/0" do
    expected = %{}

    req = CodeBuild.list_curated_environment_images()

    assert req.data == expected
  end

  test "list_projects/1" do
    expected = %{}

    req = CodeBuild.list_projects()

    assert req.data == expected
  end

  test "list_source_credentials/0" do
    expected = %{}

    req = CodeBuild.list_source_credentials()

    assert req.data == expected
  end

  test "start_build/2" do
    expected = %{"projectName" => "project"}

    req = CodeBuild.start_build("project")

    assert req.data == expected
  end

  test "stop_build/1" do
    expected = %{"id" => "123"}

    req = CodeBuild.stop_build("123")

    assert req.data == expected
  end

  test "update_project/2" do
    expected = %{"name" => "project"}

    req = CodeBuild.update_project("project")

    assert req.data == expected
  end

  test "update_webhook/2" do
    expected = %{"projectName" => "project"}

    req = CodeBuild.update_webhook("project")

    assert req.data == expected
  end

  test "normalize_opts" do
    expected = %{"sortOrder" => "ASCENDING"}

    req = CodeBuild.list_builds(sort_order: "ASCENDING")

    assert req.data == expected
  end
end
