require 'thor'
require 'colorize'
require 'arkrb/install'
module Arkrb
  class CLI < Thor

    package_name 'arkrb'

    desc "install APP_NAME", "install one of the available apps" # [4]
    method_option :list, type: :boolean, aliases: '-l'
    method_option :instance, type: :string, default: 'main', aliases: '-i'

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
            ArkRb.install.server_tools
          when :ark
            ArkRb.install.ark(name)
          else
            # do nothing
        end
      end
    end


    private

    # @return [Boolean]
    def ark_installed? instance
      ArkRb.install.ark_installed?(instance)
    end

    def print_status(item, status, how_to)
      printf format("%-20s %-30s %s\n", item, "[#{status}]", how_to)
    end

  end
end

