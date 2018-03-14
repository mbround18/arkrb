require 'arkrb/version'
require 'arkrb/constants'
require 'arkrb/error_parsing'
require 'arkrb/output_parsing'
require 'open3'

module Arkrb

  # @return [Arkrb::Install]
  def self.install
    Arkrb::Install.new
  end

  # @return [String]
  def self.executable(path = "#{USER_HOME}/bin")
    arkmanager_exec = find_executable('arkmanager', path)
    raise Arkrb::Error::ArkManagerExecutableNotFound, 'We could not find the ark_rb binary! Please install it by running Arkrb.install.server_tools or executing the command `ark_rb install tools``' if arkmanager_exec.nil?
    arkmanager_exec
  end

  # @return [Integer, String]
  def self.execute(command, command_opts = '', instance = 'main', sanitize = false)
    exec_this = format('%s %s %s @%s', executable, command.to_s.tr('_', ''), command_opts, instance)
    pp exec_this
    stdin, stdout, stderr = Open3.popen3(exec_this)
    output = stdout.read.chomp
    errors = stderr.read.chomp
    errors += 'Your ARK server exec could not be found.' if output =~ /#{'ARK server exec could not be found'}/im

    Arkrb::ErrorParsing.new.sanitize!(command, errors) unless errors.strip.empty?

    if sanitize
      output_parsing = Arkrb::OutputParsing.new
      output_parsing.sanitize!(command, output)
    else
      puts output
      puts errors
    end

  end

end
