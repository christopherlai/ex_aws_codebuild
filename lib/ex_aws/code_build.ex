defmodule ExAws.CodeBuild do
  @moduledoc """
  Operations on AWS CodeBuild.

  [AWS API Documentation](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_Operations.html)
  """

  @target_prefix "CodeBuild_20161006"

  import ExAws.Utils, only: [camelize_keys: 1]
  alias ExAws.Operation
  alias ExAws.Operation.JSON

  @doc """
  Deletes one or more builds.
  """
  @spec batch_delete_builds([binary]) :: Operation.t()
  def batch_delete_builds(ids) do
    request(:batch_delete_builds, %{"ids" => ids})
  end

  @doc """
  Gets information about builds.
  """
  @spec batch_get_builds([binary]) :: Operation.t()
  def batch_get_builds(ids) do
    request(:batch_get_builds, %{"ids" => ids})
  end

  @doc """
  Gets information about build projects.
  """
  @spec batch_get_projects([binary]) :: Operation.t()
  def batch_get_projects(names) do
    request(:batch_get_projects, %{"names" => names})
  end

  @doc """
  Creates a build project.
  """
  @spec create_project(binary, keyword) :: Operation.t()
  def create_project(name, opts \\ []) do
    params =
      opts
      |> normalize_opts()
      |> Map.merge(%{"name" => name})

    request(:create_project, params)
  end

  @doc """
  Creates a webhook for an existing AWS CodeBuild build project that has its source code 
  stored in a GitHub or Bitbucket repository, enables AWS CodeBuild to start 
  rebuilding the source code every time a code change is pushed to the repository.
  """
  @spec create_webhook(binary, binary, keyword) :: Operation.t()
  def create_webhook(name, branch, opts \\ []) do
    params =
      opts
      |> normalize_opts()
      |> Map.merge(%{"projectName" => name, "branchFilter" => branch})

    request(:create_webhook, params)
  end

  @doc """
  Deletes a build project.
  """
  @spec delete_project(binary) :: Operation.t()
  def delete_project(name) do
    request(:delete_project, %{"name" => name})
  end

  @doc """
  Deletes a set of GitHub, GitHub Enterprise, or Bitbucket source credentials.
  """
  @spec delete_source_credentials(binary) :: Operation.t()
  def delete_source_credentials(arn) do
    request(:delete_source_credentials, %{"arn" => arn})
  end

  @doc """
  Delets a webhook for an existing AWS CodeBuild build project 
  that has its source code stored in a GitHub or Bitbucket repository, 
  stops AWS CodeBuild from rebuilding the source code every time a code 
  change is pushed to the repository.
  """
  @spec delete_webhook(binary) :: Operation.t()
  def delete_webhook(name) do
    request(:delete_webhook, %{"projectName" => name})
  end

  @doc """
  Imports the source repository credentials for an AWS CodeBuild project 
  that has its source code stored in a GitHub, GitHub Enterprise, or Bitbucket repository.
  """
  @spec import_source_credentials(binary, binary, binary, binary) :: Operation.t()
  def import_source_credentials(username, token, server_type, auth_type) do
    request(
      :import_source_credentials,
      %{
        "authType" => auth_type,
        "serverType" => server_type,
        "token" => token,
        "username" => username
      }
    )
  end

  @doc """
  Resets the cache for a project.
  """
  @spec invalidate_project_cache(binary) :: Operation.t()
  def invalidate_project_cache(name) do
    request(:invalidate_project_cache, %{"projectName" => name})
  end

  @doc """
  Gets a list of build IDs, with each build ID representing a single build.
  """
  @spec list_builds :: Operation.t()
  def list_builds(opts \\ []) do
    params =
      opts
      |> normalize_opts()
      |> Map.merge(%{})

    request(:list_builds, params)
  end

  @doc """
  Gets a list of build IDs for the specified build project, 
  with each build ID representing a single build.
  """
  @spec list_builds_for_project(binary) :: Operation.t()
  def list_builds_for_project(name, opts \\ []) do
    params =
      opts
      |> normalize_opts()
      |> Map.merge(%{"projectName" => name})

    request(:list_builds_for_project, params)
  end

  @doc """
  Gets information about Docker images that are managed by AWS CodeBuild.
  """
  @spec list_curated_environment_images :: Operation.t()
  def list_curated_environment_images do
    request(:list_curated_environment_images, %{})
  end

  @doc """
  Gets a list of build project names, with each build project name 
  representing a single build project.
  """
  @spec list_projects :: Operation.t()
  def list_projects(opts \\ []) do
    params =
      opts
      |> normalize_opts()
      |> Map.merge(%{})

    request(:list_projects, params)
  end

  @doc """
  Returns a list of SourceCredentialsInfo objects.
  """
  @spec list_source_credentials :: Operation.t()
  def list_source_credentials do
    request(:list_source_credentials, %{})
  end

  @doc """
  Starts running a build.
  """
  @spec start_build(binary, keyword) :: Operation.t()
  def start_build(name, opts \\ []) do
    params =
      opts
      |> normalize_opts()
      |> Map.merge(%{"projectName" => name})

    request(:start_build, params)
  end

  @doc """
  Attempts to stop running a build.
  """
  @spec stop_build(binary) :: Operation.t()
  def stop_build(id) do
    request(:stop_build, %{"id" => id})
  end

  @doc """
  Changes the settings of a build project.
  """
  @spec update_project(binary, keyword) :: Operation.t()
  def update_project(name, opts \\ []) do
    params =
      opts
      |> normalize_opts()
      |> Map.merge(%{"name" => name})

    request(:update_project, params)
  end

  @doc """
  Updates the webhook associated with an AWS CodeBuild build project.
  """
  @spec update_webhook(binary, keyword) :: Operation.t()
  def update_webhook(name, opts \\ []) do
    params =
      opts
      |> normalize_opts()
      |> Map.merge(%{"projectName" => name})

    request(:update_webhook, params)
  end

  defp normalize_opts({k, v}, acc) do
    Map.put(acc, to_lower_camel_case(k), v)
  end

  defp normalize_opts(opts) do
    opts
    |> Enum.into(%{})
    |> camelize_keys()
    |> Enum.reduce(%{}, &normalize_opts/2)
  end

  defp to_lower_camel_case(string) do
    {first, rest} = String.split_at(string, 1)

    String.downcase(first) <> rest
  end

  defp request(action, data) do
    operation =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    JSON.new(:codebuild, %{
      data: data,
      headers: [
        {"x-amz-target", "#{@target_prefix}.#{operation}"},
        {"content-type", "application/x-amz-json-1.1"}
      ]
    })
  end
end
