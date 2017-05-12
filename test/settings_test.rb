require 'test_helper'

class SettingsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Settings::VERSION
  end

  def test_it_does_something_useful
    Settings.config.set_config_folder('../test/sample_app/config/settings')
    Settings.load!

    assert Settings.env == 'test'
    assert Settings.hello == 'HY'
  end
end
