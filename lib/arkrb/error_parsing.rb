require 'arkrb/error'
module Arkrb
  class ErrorParsing
    def sanitize!(command, error_output, command_opts = nil)
      ark_exe_not_found = potential_errors[:ark_exe_not_found]
      raise ark_exe_not_found[:class], ark_exe_not_found[:message] if error_output =~ /#{ark_exe_not_found[:cause]}/im
      server_offline = potential_errors[:server_offline]
      raise server_offline[:class], server_offline[:message] if error_output =~ /#{server_offline[:cause]}/im

      case command
        when :install
          install_command(error_output)
        else
          raise_unknown_error(command, error_output, command_opts)
      end
    end

    def install_command(error_output)
      missing_32_gcc = potential_errors[:missing_32_gcc]
      case error_output
        when /#{missing_32_gcc[:cause]}/im
          raise missing_32_gcc[:class], missing_32_gcc[:message]
        else
          raise_unknown_error('install', error_output)
      end
    end

    private

    def potential_errors
      @potential_errors ||= {
          missing_32_gcc: {
              cause: '/steamcmd/linux32/steamcmd: No such file or directory',
              class: Arkrb::Error::SteamCMDError,
              message: 'It appears that you are missing the lib32gcc1 package please have an Administrator install it!'
          },
          ark_exe_not_found: {
              cause: 'ARK server exec could not be found',
              class: Arkrb::Error::ArkExecutableNotFound,
              message: 'Whooah! The Ark Server Executable was not found, please install the ark server using `arkrb install ark`'
          },
          server_offline: {
              cause: 'connection refused',
              class: Arkrb::Error::ServerOffline,
              message: 'The server appears to be offline!'
          }
      }
    end

    def raise_unknown_error(command, error_output, command_opts = nil)
      error_message = (command_opts.nil?) ?
                          format("An unknown error has occurred while attempting to run command %s\n%s", command, error_output) :
                          format("An unknown error has occurred while attempting to run command %s with opts %s\n%s", command, command_opts, error_output)
      raise Arkrb::Error::UnknownError, error_message
    end

  end
end
