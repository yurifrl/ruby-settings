module Settings::Default
  def self.config_folder_path
    File.join(Dir.pwd, 'config', 'settings')
  end
end
