module Arkrb
  module Error

    class CustomError < RuntimeError
    end

    class UnknownError < CustomError
    end

    class ExecutableAlreadyExists < CustomError
    end

    class ArkManagerExecutableNotFound < CustomError
    end

    class CURLNotInstalled < CustomError
    end

    class BASHNotInstalled < CustomError
    end

    class InstallScriptMD5Changed < CustomError
    end

    class SteamCMDError < CustomError
    end

    class ArkExecutableNotFound < CustomError
    end

    class ServerAlreadyRunning < CustomError
    end

  end

end


