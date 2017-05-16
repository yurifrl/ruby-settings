class Settings::PathValidator
  class Error < RuntimeError; end
  class Error::InvalidPath < Error ; end
  class Error::NilPath < Error ; end
  class Error::EmptyPath < Error ; end
  class Error::MissingEnvironmentSettingsFile < Error ; end

  def self.call(path)
    raise Error::NilPath if path.nil?
    raise Error::EmptyPath if path.empty?
    file_check!(path, "test")
    # file_check!(path, "development")
    # file_check(path, "production")
    nil
  end

  private
  def self.file_check!(path, env)
    return nil if File.exists?(path_maker(path, env))
    raise Error::MissingEnvironmentSettingsFile, "missing `#{path_maker(path, env)}`"
  end

  def self.path_maker(path, env)
    File.join(path, "#{env}.yml")
  end
end
