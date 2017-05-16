require 'settings/path_validator'
require "settings/default"

class Settings::Config

  class Error < RuntimeError; end

  def initialize(config_folder: Settings::Default.config_folder_path)
    @config_folder = set_config_folder(config_folder)
  end

  def set_config_folder(path)
    verify_valid_path!(path)
    path
  end

  def get_config_folder
    @config_folder
  end

  private
  def verify_valid_path!(path)
    Settings::PathValidator.(path)
    nil
  end
end

