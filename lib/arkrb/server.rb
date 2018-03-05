require 'mkmf'
require 'arkrb'
require 'arkrb/error'

module Arkrb
  class Server

    def initialize(instance_name, sanitize_output = true)
      @instance_name = instance_name
      @sanitize_output = sanitize_output
    end

    attr_reader :instance_name

    def install
      arkmanager_exec :install
    end

    # @return [True, Exception]
    def start!(verbose = false)
      arkmanager_exec :start
    end

    # @return [True, Exception]
    def stop!
      arkmanager_exec :stop
    end

    # @return [True, Exception]
    def restart!
      arkmanager_exec :restart
    end

    # @return [True, Exception]
    def update!
      arkmanager_exec :update
    end

    # @return [True, Exception]
    def backup!
      arkmanager_exec :backup
    end

    # @return [True, Exception]
    def save_world!
      arkmanager_exec :save_world
    end

    # @return [True, Exception]
    def enable_mod(mod_id)
      arkmanager_exec(:enable_mod, mod_id)
    end

    # @return [True, Exception]
    def disable_mod(mod_id)
      arkmanager_exec(:disable_mod, mod_id)
    end

    # @return [True, Exception]
    def install_mod(mod_id)
      arkmanager_exec(:install_mod, mod_id)
    end

    # @return [True, Exception]
    def uninstall_mod(mod_id)
      arkmanager_exec(:uninstall_mod, mod_id)
    end

    # @return [True, Exception]
    def reinstall_mod(mod_id)
      arkmanager_exec(:reinstall_mod, mod_id)
    end

    # @return [True, Exception]
    def broadcast(message)
      arkmanager_exec(:broadcast, message)
    end

    # @return [Object]
    def rcon_cmd(command)
      arkmanager_exec(:rcon, command)
    end

    # @return [Boolean]
    def update_available?
      arkmanager_exec :check_update
    end

    # @return [Boolean]
    def mod_updates_available?
      arkmanager_exec :check_mod_update
    end

    private

    def arkmanager_exec(command, command_opts = '')
      Arkrb.execute(command, command_opts, instance_name, @sanitize_output)
    end

  end
end