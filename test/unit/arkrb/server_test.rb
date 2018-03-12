require 'arkrb/server'
require_relative '../../test_helper'
class ArkrbServer < Arkrb::Server

  def arkmanager_exec(command, args = [])
    [command, args]
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
    assert_includes @server.install, :install
  end

  def test_start!
    assert_includes @server.start!, :start
  end


  def test_stop!
    assert_includes @server.stop!, :stop
  end


  def test_restart!
    assert_includes @server.restart!, :restart
  end


  def test_update!
    assert_includes @server.update!, :update
  end


  def test_backup!
    assert_includes @server.backup!, :backup
  end


  def test_save_world!
    assert_includes @server.save_world!, :save_world
  end


  def test_enable_mod
    assert_equal [:enable_mod, 12345678], @server.enable_mod(12345678)
  end


  def test_disable_mod
    assert_equal [:disable_mod, 12345678], @server.disable_mod(12345678)
  end


  def test_install_mod
    assert_equal [:install_mod, 12345678], @server.install_mod(12345678)

  end


  def test_uninstall_mod
    assert_equal [:uninstall_mod, 12345678], @server.uninstall_mod(12345678)
  end


  def test_reinstall_mod
    assert_equal [:reinstall_mod, 1234568], @server.reinstall_mod(1234568)
  end


  def test_broadcast
    assert_equal [:broadcast, "Hello World!"], @server.broadcast('Hello World!')
  end

  # @return [Object]
  def test_rcon_cmd
    assert_equal [:rcon, "test"], @server.rcon_cmd('test')
  end

  # @return [Boolean]
  def test_update_available?
    assert_equal [:check_update, []], @server.update_available?
  end

  # @return [Boolean]
  def test_mod_updates_available?
    assert_equal [:check_mod_update, []], @server.mod_updates_available?
  end

end