require 'mkmf'
require 'oga'
require 'open-uri'
require 'arkrb'
require 'arkrb/error'
require 'arkrb/server/mods'
module Arkrb
  class Server

    def initialize(instance_name, sanitize_output = true)
      @instance_name = instance_name
      @sanitize_output = sanitize_output
      mod_list
    end

    attr_reader :instance_name, :mod_list

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

    def status!
      arkmanager_exec :status
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

    def mod_list
      @mod_list ||=  Arkrb::Mods.new
    end

    private

    def arkmanager_exec(command, command_opts = '')
      Arkrb.execute(command, command_opts, instance_name, @sanitize_output)
    end

  end
end

# server = Arkrb::Server.new('main')
# server.mod_list.add(731604991)
#
# pp server
#
# pp server.mod_list.to_h
#
#
#
#     mod_list = Arkrb::Mods.new
#
# pp mod_list
# mod_a = 731604991
# mod_b = 812655342
#
# mod_list.add(731604991)
# mod_list.add(812655342)
# pp mod_list.to_h
# # mod_list.add(731604991)
# # pp mod_list.find_by_id(mod_a).to_h