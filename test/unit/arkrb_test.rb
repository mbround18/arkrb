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

end
