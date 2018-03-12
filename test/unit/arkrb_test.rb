require_relative '../test_helper'

class ArkrbTest < TestHelper

  def test_that_it_has_a_version_number
    refute_nil Arkrb::VERSION
  end

  def test_version_number_follows_symantic
    version = Arkrb::VERSION.split('.')
    assert_equal 3, version.count
    version.each { |n| assert_match /^[0-9]*$/, n }
  end

  def test_bash_exec_found
    refute_nil Arkrb::BASH_EXEC
    assert File.exist?(Arkrb::BASH_EXEC)
  end

  def test_curl_exec_found
    refute_nil Arkrb::CURL_EXEC
    assert File.exist?(Arkrb::CURL_EXEC)
  end

  def test_user_home_found
    refute_nil Arkrb::USER_HOME
    assert File.exist?(Arkrb::USER_HOME)
  end

  def test_ark_server_tools_md5_is_string
    refute_nil Arkrb::ARK_SERVER_TOOLS_MD5
  end

end
