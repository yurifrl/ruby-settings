class Settings::Config
  module Default
    def self.settings_file_path
      File.join(Dir.pwd, 'config', 'settings')
    end
  end

  class Error < StandardError ; end
  class Error::NilPath < Error ; end

  attr_reader :config_folder

  def initialize(options = {})
    @config_folder = set_config_folder(options[:config_folder])
  end

  def set_config_folder(path)
    verify_valid_path!(path)
    path
  rescue Error::NilPath => e
    Default.settings_file_path()
  end

  private
  def verify_valid_path!(path)
    raise Error::NilPath if path.nil?
    nil
  end
end

