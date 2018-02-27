module ArkRb
  module Error
    class CustomError < RuntimeError
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

  end

end


