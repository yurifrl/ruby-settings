require 'test_helper'

class SettingsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Settings::VERSION
  end

  def test_it
    Settings.set_config_folder('../test/sample_app/config/settings')
    binding.pry

    # Settings.load!

    assert Settings.env == 'test'
    assert Settings.hello == 'HY'
  end
end
