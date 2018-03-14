module Arkrb
  class OutputParsing

    def sanitize!(command, output)
      if public_methods(false).include?(command.to_sym)
        method(command.to_sym).call(output)
      else
        raise Arkrb::Error::SanitizationUnsupportedForThisMethod, "\n#{output}"
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
      if output =~ /#{'the server is now running'}/im
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
      if output =~ /#{'The server has been stopped'}/im
        true
      else
        if output =~ /#{'The server is already stopped'}/im
          raise Arkrb::Error::ServerAlreadyStopped, output
        else
          raise_unknown_error(__method__.to_sym, output)
        end
      end
    end

    # @return [True, Exception]
    def restart(output)
      if output =~ /#{'the server is now running'}/im
        true
      else
        raise_unknown_error(__method__.to_sym, output)
      end
    end

    def status(output)
      status_items = {}
      defaults = {
          running: nil, pid: nil, listening: nil, name: nil,
          players: nil, active_players: nil, online: nil,
          arkservers_link: nil, build_id: nil, version: nil
      }

      status = output.gsub(/\e\[([;\d]+)?m/, '')
      if status =~ /Server running/im
        status = status.split("\n").map {|s| s.strip}
        status.shift
        status.each do |item|
          item_info = item.split(':', 2)
          status_items[item_info.first.gsub('Server ', '').strip.downcase.tr(' ', '_').to_sym] = item_info[1].strip
        end
        status_items[:running] = (status_items.fetch(:running, 'no') =~ /yes/im) ? true : false
        status_items[:listening] = (status_items.fetch(:listening, 'no') =~ /yes/im) ? true : false
        status_items[:online] = (status_items.fetch(:online, 'no') =~ /yes/im) ? true : false
        defaults.merge(status_items)
      else
        raise_unknown_error(__method__.to_sym, output)
      end
    end

    # @return [True, Exception]
    def update(output)
      if output =~ /#{'already up to date '}/im || output =~ /#{'updated'}/im
      else
        raise_unknown_error(__method__.to_sym, output)
      end
    end


    # @return [True, Exception]
    def backup(output)
      if output =~ /Created Backup/im
        console_response = output.split("\n").map {|x| x.gsub(/\e\[([;\d]+)?m/, '').strip}
        dir_path = console_response.find {|x| x =~ /Saved arks directory is/im}.split('directory is').last.strip
        file_name = console_response.find {|x| x =~ /Created Backup/im}.split(':').last.strip
        {
            status: 'success',
            path: File.join(dir_path, file_name)
        }
      else
        raise_unknown_error(__method__.to_sym, output)
      end
    end

    # @return [True, Exception]
    def save_world(output)
      if output =~ /world saved/im
        true
      else
        raise_unknown_error(__method__.to_sym, output)
      end
    end

    # @return [True, Exception]
    def enable_mod(output)
      if output =~ /enable mod/im
        true
      else
        raise_unknown_error(__method__.to_sym, output)
      end
    end

    # @return [True, Exception]
    def disable_mod(output)
      if output =~ /disablemod/im
        true
      else
        raise_unknown_error(__method__.to_sym, output)
      end
    end

    # @return [True, Exception]
    def install_mod(output)
      if output =~ /mod [0-9]+ installed/im
        true
      else
        raise_unknown_error(__method__.to_sym, output.gsub("\r", "\n"))
      end
    end

    # @return [True, Exception]
    def uninstall_mod(output)
      if output =~ /uninstallmod/im
        true
      else
        raise_unknown_error(__method__.to_sym, output)
      end
    end

    # @return [True, Exception]
    def reinstall_mod(output)
      if output =~ /mod [0-9]+ installed/im
        true
      else
        raise_unknown_error(__method__.to_sym, output.gsub("\r", "\n"))
      end
    end

    # @return [True, Exception]
    def broadcast(output)
      if output =~ /command processed/im
        true
      else
        raise_unknown_error(__method__.to_sym, output.gsub("\r", "\n"))
      end
    end

    # @return [Object]
    def rconcmd(output)
      output
    end

    # @return [Boolean]
    # def update_available?(output)
    #   arkmanager_exec :check_update
    # end

    # @return [Boolean]
    # def mod_updates_available?(output)
    #   output
    # end

    private

    def raise_unknown_error(command, output)
      error_message = format("An unknown error has occurred while attempting to run command %s\n%s", command, output)
      raise Arkrb::Error::UnknownError, error_message
    end

  end
end
