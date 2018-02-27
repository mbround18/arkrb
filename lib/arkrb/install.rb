require 'mkmf'
require 'digest'
require 'arkrb/server'
require 'arkrb/ark_server_tools_md5'

BASH_EXEC = find_executable 'bash' unless defined? BASH_EXEC
CURL_EXEC = find_executable 'curl' unless defined? CURL_EXEC
USER_HOME = Dir.home unless defined? USER_HOME
module Arkrb
  class Install

    # @return [True, Exception]
    def server_tools
      server_tools_install_sh_path = "/tmp/server_tools_install_#{Time.now.strftime('%Y%m%d-%H%M%S')}.sh"
      File.delete(server_tools_install_sh_path) if File.exist?(server_tools_install_sh_path)

      `#{CURL_EXEC} -sL http://git.io/vtf5N > #{server_tools_install_sh_path}`
      file_md5 = Digest::MD5.hexdigest File.read(server_tools_install_sh_path)

      raise Arkrb::Error::InstallScriptMD5Changed, "Uhh oh!!! #{file_md5} did not match #{ARK_SERVER_TOOLS_MD5}; Please report this issue at https://github.com/mbround18/arkrb" unless file_md5.eql? ARK_SERVER_TOOLS_MD5

      `#{BASH_EXEC} #{server_tools_install_sh_path} --me --perform-user-install`

      unless find_executable('arkmanager', "#{USER_HOME}/bin")
        File.open("#{USER_HOME}/.bashrc", 'a') do |file|
          file.write "export PATH=$PATH:#{File.expand_path(USER_HOME + '/bin')}"
        end
        puts 'arkmanager was successfully added to your path' if find_executable('arkmanager', "#{USER_HOME}/bin")
      end
    end

    def ark(instance = 'main')
      Arkrb::Server.new(instance).install
      # ArkRb.execute('install', instance, false)
    end

    def ark_installed?(instance = 'main')
      false
    end

  end
end
