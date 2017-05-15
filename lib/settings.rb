# @dependency ENV['RACK_ENV']
# @dependency dotenv, enviromentment variables
# @dependency File
# @dependency IO
# @dependency ERB
# @dependency YAML
# @dependency folder structure './config/settings/*.yml'
# @dependency env files './*.env'
require 'yaml'
require 'erb'
require 'dotenv'
require 'pry'

require "settings/version"
require "settings/config"

# Easy way to add multi-environment yaml settings to the application
module Settings
  class Error < StandardError ; end
  class Error::FileForEnvironmentNotFound < Error ; end
  class Error::FileSintaxError < Error ; end
  class Error::InvalidNameForKey < Error ; end
  class Error::RackEnvNotSet < Error ; end

  class << self

    #command
    def initialize_config!
      create_class_method_on_settings_class!(:config, Config.new)
      nil
    end

    #query
    def get_config
      self.config
    end

    #query
    def set_config_folder(path)
      self.config.set_config_folder(path)
    end

    #query
    def get_config_folder
      self.config.config_folder
    end

    #command
    def load!
      load_dot_files!

      env = get_current_env
      config_path = get_config_path(env)
      yml_file = read_yml_file(config_path)
      parsed_yml = parse_yml_file(yml_file)
      hash = convert_yml_to_hash(parsed_yml)

      hash_to_class_methods!(hash)
      create_an_options_method_on_settings_class!(hash)

      nil
    end

    private
    #command
    def load_dot_files!
      Dotenv.load
      nil
    end

    #query
    def get_current_env
      env = ENV['RACK_ENV']
    rescue
      raise Error::RackEnvNotSet if env.nil?
    end

    #query
    def get_config_path(env)
      File.join(get_config_folder, "#{env}.yml")
    end

    #query
    def read_yml_file(path)
      IO.read(path)
    rescue Errno::ENOENT
      raise Error::FileForEnvironmentNotFound
    end

    #query
    def parse_yml_file(file)
      ERB.new(file).result
    end

    #query
    def convert_yml_to_hash(file)
      YAML.load(file)
    rescue Psych::SyntaxError
      raise Error::FileSintaxError
    end

    #command
    def hash_to_class_methods!(hash)
      hash.keys.each do |x|
        verify_if_valid_name(x)
        create_class_method_on_settings_class!(x, hash[x])
      end
      nil
    end

    #command
    def verify_if_valid_name(method_name)
      raise Error::InvalidNameForKey if ['config'].include? method_name
      nil
    end

    #command
    def create_class_method_on_settings_class!(name, value)
      Settings.define_singleton_method(name) { value }
      nil
    end

    #command
    def create_an_options_method_on_settings_class!(hash)
      create_class_method_on_settings_class!(:options, hash.keys)
      nil
    end
  end
end

Settings.initialize_config!
# Settings.load!
