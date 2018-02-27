require "arkrb/version"

module Arkrb

  # @return [ArkRb::Install]
  def self.install
    ArkRb::Install.new
  end

  # @return [String]
  def self.executable
    arkmanager_exec = find_executable('arkmanager')
    raise ArkRb::Error::ArkManagerExecutableNotFound, 'We could not find the ark_rb binary! Please install it by running Arkrb.install.server_tools or executing the command `ark_rb install tools``' if arkmanager_exec.nil?
    arkmanager_exec
  end

  # @return [Integer, String]
  def self.execute(command, instance = 'main', headless = false, std_out = '/dev/null', std_error = '/dev/null', detach = true)
    exec_this = format('%s %s @%s', executable, command, instance)
    if headless
      pid = spawn(exec_this, out: std_out, err: std_error)
      Process.detach(pid) if detach
      pid
    else
      system(exec_this)
    end
  end

end
