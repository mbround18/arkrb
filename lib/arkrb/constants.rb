require 'mkmf'

module Arkrb

  old_mkmf_log = MakeMakefile::Logging.instance_variable_get(:@logfile)
  MakeMakefile::Logging.instance_variable_set(:@logfile, '/dev/null')
  BASH_EXEC = find_executable0 'bash' unless defined? BASH_EXEC
  CURL_EXEC = find_executable0 'curl' unless defined? CURL_EXEC
  MakeMakefile::Logging.instance_variable_set(:@logfile, old_mkmf_log)

  USER_HOME = Dir.home unless defined? USER_HOME
  ARK_SERVER_TOOLS_MD5 = '773b17d67eff8944bcd0e2a39089c96d'

end