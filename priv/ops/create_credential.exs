# Script to create a Credential
# It can be run like this
#    mix ops.credential.create --client-id "aaaaa" --secret "super secret"
#

require Logger

defmodule OpsHelper do
  def abort_execution(message) do
    Logger.error message
    exit(1)
  end
end

Logger.info "Create Credential"


argv = System.argv()
Logger.debug "argv=#{inspect argv}"


switches_spec = [client_id: :string, secret: :string]
parsed_args = OptionParser.parse!(argv, strict: switches_spec)
Logger.debug "parsed_args=#{inspect parsed_args}"


case parsed_args do
  {[client_id: client_id, secret: secret], []} ->
    Logger.debug "client_id=#{client_id}; secret=#{secret};"

    %HMServer.Credential{client_id: client_id, secret_key: secret}
    |> HMServer.Repo.insert!

    Logger.info "Success!!"
  _ ->
    OpsHelper.abort_execution("Received Invalid Arguments!!")
end


