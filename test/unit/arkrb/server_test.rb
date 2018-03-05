require 'arkrb/server'
require_relative '../../test_helper'
class ArkrbServer < Arkrb::Server

  def arkmanager_exec(command)
    command
  end

end

class ServerTest < TestHelper

  def setup
    @server = ArkrbServer.new('main')
  end


  def test_instance_name
    instance_name = 'test_instance'
    ark = Arkrb::Server.new(instance_name)
    assert ark.instance_name == instance_name
  end

  def test_install
    assert_equal 'install', @server.install
  end

  def test_start!
    assert_equal 'start', @server.start!
  end


  def test_stop!
    assert_equal 'stop', @server.stop!
  end


  def test_restart!
    assert_equal 'restart', @server.restart!
  end


  def test_update!
    assert_equal 'update', @server.update!
  end


  def test_backup!
    assert_equal 'backup', @server.backup!
  end


  def test_save_world!
    assert_equal 'saveworld', @server.save_world!
  end


  def test_enable_mod
    assert_equal 'enablemod 12345678', @server.enable_mod(12345678)
  end


  def test_disable_mod
    assert_equal 'disablemod 12345678', @server.disable_mod(12345678)
  end


  def test_install_mod
    assert_equal 'installmod 12345678', @server.install_mod(12345678)

  end


  def test_uninstall_mod
    assert_equal 'uninstallmod 12345678', @server.uninstall_mod(12345678)
  end


  def test_reinstall_mod
    assert_equal 'reinstallmod 1234568', @server.reinstall_mod(1234568)
  end


  def test_broadcast
    assert_equal "broadcast 'Hello World!'", @server.broadcast('Hello World!')
  end

  # @return [Object]
  def test_rcon_cmd
    assert_equal 'rcon test', @server.rcon_cmd('test')
  end

  # @return [Boolean]
  def test_update_available?
    assert_equal 'checkupdate', @server.update_available?
  end

  # @return [Boolean]
  def test_mod_updates_available?
    assert_equal 'checkmodupdate', @server.mod_updates_available?
  end

end