require 'test_helper'
require 'settings'

class SettingsTest < Minitest::Test
  SAMPLE_APP_CONFIG_PATH = "test/sample_app/config/settings"

  def test_it
    Settings.initialize_config!(SAMPLE_APP_CONFIG_PATH)

    Settings.load!

    assert Settings.env == 'test'
    assert Settings.hello == 'HY'
  end
end
