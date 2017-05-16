require 'settings/config'
require 'settings/default'

module Settings::ConfigFactory
  def self.call(that, path)
    if that.respond_to?(:config)
      return that.config
    end

    if path.nil?
      Settings::Config.new(config_folder: path)
    else
      Settings::Config.new(config_folder: Settings::Default.config_folder_path)
    end
  end
end
