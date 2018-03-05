require 'mkmf'
require 'digest'
require 'arkrb/server'
require 'arkrb/constants'

module Arkrb
  class Install

    # @return [True, Exception]
    def server_tools
      server_tools_install_sh_path = "/tmp/server_tools_install_#{Time.now.strftime('%Y%m%d-%H%M%S')}.sh"
      File.delete(server_tools_install_sh_path) if File.exist?(server_tools_install_sh_path)

      `#{CURL_EXEC} -sL http://git.io/vtf5N > #{server_tools_install_sh_path}`
      file_md5 = Digest::MD5.hexdigest File.read(server_tools_install_sh_path)

      raise Arkrb::Error::InstallScriptMD5Changed, "Uhh oh!!! #{file_md5} did not match #{Arkrb::ARK_SERVER_TOOLS_MD5}; Please report this issue at https://github.com/mbround18/Arkrb" unless file_md5.eql? Arkrb::ARK_SERVER_TOOLS_MD5

      `#{BASH_EXEC} #{server_tools_install_sh_path} --me --perform-user-install`

      unless find_executable('arkmanager', "#{Arkrb::USER_HOME}/bin")
        File.open("#{Arkrb::USER_HOME}/.bashrc", 'a') do |file|
          file.write "export PATH=$PATH:#{File.expand_path(Arkrb::USER_HOME + '/bin')}"
        end
        puts 'arkmanager was successfully added to your path' if find_executable('arkmanager', "#{Arkrb::USER_HOME}/bin")
      end
    end

    def ark(instance = 'main', sanitize_output = false)
      Arkrb::Server.new(instance, sanitize_output).install
    end

  end
end
