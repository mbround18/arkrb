require 'thor'
require 'colorize'
require 'arkrb/constants'
require 'arkrb/install'
module Arkrb
  class CLI < Thor

    package_name 'arkrb'
    class_option :instance, type: :string, default: 'main', aliases: '-i'

    desc "install APP_NAME", "install one of the available apps" # [4]
    method_option :list, type: :boolean, aliases: '-l'

    def install(name = nil)
      if options[:list] || name.nil?
        arkmanager_status = (find_executable('arkmanager').nil?) ? 'Not Installed'.red : 'Installed'.green
        ark_install_status = (ark_installed?(options[:instance])) ? 'Installed'.green : 'Not Installed'.red
        # arkmanager_status = 'Not Installed'.red
        printf format("%-20s Status %21s\n", 'APP_NAME', 'Description')
        print_status('ark_manager', arkmanager_status, 'Installs ark-server-tools; Install with: ark_rb install tools')
        print_status('ark_server', ark_install_status, 'Installs the ark server; Install with: ark_rb install ark')
      end
      unless name.nil?
        case name.to_sym
          when :arkmanager, :ark_manager, :tools
            Arkrb.install.server_tools
          when :ark
            Arkrb.install.ark(options[:instance], false)
          else
            # do nothing
        end
      end
    end

    desc 'start', 'Starts the ark server'

    def start
      ark_server(options[:instance]).start!
    end

    desc 'stop', 'Stops the ark server'

    def stop
      ark_server(options[:instance]).stop!
    end

    desc 'restart', 'Restarts the ark server'

    def restart
      ark_server(options[:instance]).restart!
    end

    desc 'update', 'Updates the ark server'

    def update
      ark_server(options[:instance]).update!
    end

    desc 'backup', 'Backups the ark server'

    def backup
      ark_server(options[:instance]).backup!
    end

    desc 'saveworld', 'Saves the ark world'

    def save_world!
      ark_server(options[:instance]).save_world!
    end

    desc 'enablemod MOD_ID', 'Enables a mod via mod ID'

    def enablemod(mod_id)
      ark_server(options[:instance]).enable_mod mod_id
    end

    desc 'disablemod MOD_ID', 'Disables a mod via mod ID'

    def disablemod(mod_id)
      ark_server(options[:instance]).disable_mod mod_id
    end

    desc 'installmod MOD_ID', 'Installs a mod via mod ID'

    def installmod(mod_id)
      ark_server(options[:instance]).install_mod mod_id
    end

    desc 'uninstallmod MOD_ID', 'Uninstalls the mod via mod ID'

    def uninstallmod(mod_id)
      ark_server(options[:instance]).reinstall_mod mod_id
    end

    desc 'reinstallmod MOD_ID', 'Reinstalls the mod via mod ID'

    def reinstallmod(mod_id)
      ark_server(options[:instance]).reinstall_mod mod_id
    end

    desc 'broadcast MESSAGE', 'Broadcasts a message to the server. Make sure to put it in parentheses.'

    def broadcast(message)
      ark_server(options[:instance]).broadcast message
    end

    desc 'rcon COMMAND', 'Runs an rcon command on the ark server'

    def rcon(command)
      ark_server(options[:instance]).rcon_cmd command
    end

    desc 'checkupdate', 'Checks for updates to ark'

    def checkupdate
      ark_server(options[:instance]).update_available?
    end

    desc 'checkmodupdates', 'Checks for updates on installed mods'

    def checkmodupdates
      ark_server(options[:instance]).mod_updates_available?
    end

    private

    # @return [Boolean]
    def ark_installed?(instance = 'main')
      Arkrb.install.ark_installed?(instance)
    end

    # @return [Arkrb::Server]
    def ark_server(instance = 'main')
      Arkrb::Server.new(instance, false)
    end

    def print_status(item, status, how_to)
      printf format("%-20s %-30s %s\n", item, "[#{status}]", how_to)
    end

  end
end

