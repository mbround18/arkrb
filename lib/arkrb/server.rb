require 'mkmf'
require 'oga'
require 'open-uri'
require 'arkrb'
require 'arkrb/error'
require 'arkrb/server/mods'
require 'arkrb/server/player'
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
    def update!(update_mods = false)
      if update_mods
        arkmanager_exec :update, '--update-mods'
      else
        arkmanager_exec :update
      end
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
      arkmanager_exec(:rconcmd, command.to_s)
    end

    def get_player_list
      sanitize_filter = @sanitize_output
      @sanitize_output = true
      users = []
      player_list = rcon_cmd('ListPlayers')
                        .split("\n")
                        .map {|m| m.delete('\\"').strip}
                        .reject(&:empty?)
      player_list.delete_if {|x| x =~ /Running command/im}
      if player_list.count == 1 && player_list.first =~ /no/im
        users << Player.new(player_list.first, player_list.first, player_list.first)
      else
        player_list.map! {|p| %i(name steam_id).zip(p.gsub!(/^[0-9]+. /im, '').split(', ')).to_h}
        player_list.each do |u|
          player_id = rcon_cmd("GetPlayerIDForSteamID #{u[:steam_id].to_i}")
                          .split("\n")
                          .delete_if {|x| x =~ /Running command/im}
                          .map! {|x| x.delete('\\"').strip}
                          .reject(&:empty?)
                          .first.split('PlayerID: ').last
          users << Player.new(u[:name], u[:steam_id], player_id)
        end
      end
      @sanitize_output = sanitize_filter
      users
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
      @mod_list ||= Arkrb::Mods.new
    end

    private

    def arkmanager_exec(command, command_opts = '')
      Arkrb.execute(command, command_opts, instance_name, @sanitize_output)
    end

  end
end
