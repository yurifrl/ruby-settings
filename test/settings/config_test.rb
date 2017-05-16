require 'test_helper'
require 'settings/config'

class Settings::ConfigTest < Minitest::Test
  SAMPLE_APP_CONFIG_PATH = "test/sample_app/config/settings"
  INVALID_SAMPLE_APP_CONFIG_PATH = "test/sample_app/config"

  def test_should_raise_an_error
    exception = assert_raises Settings::PathValidator::Error::MissingEnvironmentSettingsFile do
      Settings::Config.new(config_folder: INVALID_SAMPLE_APP_CONFIG_PATH)
    end

    assert_equal('missing `test/sample_app/config/test.yml`', exception.message)
  end

  def test_should_raise_an_error_with_the_default_config
    exception = assert_raises Settings::PathValidator::Error::MissingEnvironmentSettingsFile do
      Settings::Config.new
    end
  end

  def test_should_work_fine
    config = Settings::Config.new(config_folder: SAMPLE_APP_CONFIG_PATH)
    assert_equal(config.get_config_folder, "test/sample_app/config/settings")
  end
end
