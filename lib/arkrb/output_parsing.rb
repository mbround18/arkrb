module Arkrb
  class OutputParsing

    def sanitize!(command, output)
      case command
        when :install
          install(output)
        when :start
          start(output)
        when :stop
          stop(output)
        else
          # Do nothing
      end
    end


    def install(output)
      if output.strip.empty?
        true
      else
        if output =~ /#{'server already running'}/im
          raise Arkrb::Error::ServerAlreadyRunning, output
        else
          raise_unknown_error(:install, output)
        end
      end
    end

    # @return [True, Exception]
    def start(output)
      if output.strip.empty?
        true
      else
        if output =~ /#{'server already running'}/im
          raise Arkrb::Error::ServerAlreadyRunning, output
        else
          raise_unknown_error(:start, output)
        end
      end
    end

    # @return [True, Exception]
    def stop(output)
      puts output
    end

    # @return [True, Exception]
    # def restart(output)
    #   arkmanager_exec :restart
    # end

    # @return [True, Exception]
    # def update(output)
    #   arkmanager_exec :update
    # end

    # @return [True, Exception]
    # def backup(output)
    #   arkmanager_exec :backup
    # end

    # @return [True, Exception]
    # def save_world(output)
    #   arkmanager_exec :save_world
    # end

    # @return [True, Exception]
    # def enable_mod(output)
    #   arkmanager_exec(:enable_mod, mod_id)
    # end

    # @return [True, Exception]
    # def disable_mod(output)
    #   arkmanager_exec(:disable_mod, mod_id)
    # end

    # @return [True, Exception]
    # def install_mod(output)
    #   arkmanager_exec(:install_mod, mod_id)
    # end

    # @return [True, Exception]
    # def uninstall_mod(output)
    #   arkmanager_exec(:uninstall_mod, mod_id)
    # end

    # @return [True, Exception]
    # def reinstall_mod(output)
    #   arkmanager_exec(:reinstall_mod, mod_id)
    # end

    # @return [True, Exception]
    # def broadcast(output)
    #   arkmanager_exec(:broadcast, message)
    # end

    # @return [Object]
    # def rcon_cmd(output)
    #   arkmanager_exec(:rcon, command)
    # end

    # @return [Boolean]
    # def update_available?(output)
    #   arkmanager_exec :check_update
    # end

    # @return [Boolean]
    # def mod_updates_available?(output)
    #   arkmanager_exec :check_mod_update
    # end

    private

    # def filter_known_errors(output)
    #   yield(output)
    # end

    def raise_unknown_error(command, output)
      error_message = format("An unknown error has occurred while attempting to run command %s\n%s", command, output)
      raise Arkrb::Error::UnknownError, error_message
    end

  end
end
