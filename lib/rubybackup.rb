require "yaml"

module RubyBackup

    def RubyBackup.load_config(config_file = File.join(Dir.pwd, "config/config.yml"))
        @@config = YAML.load_file(config_file)
        @@config[:app_dir] = Dir.pwd
        @@config[:ext_pattern] = "*.{#{@@config[:ext_blacklist].join(",")}}"
    end

    def RubyBackup.config
        @@config
    end

    def RubyBackup.source_dir
        @@config[:source_dir]
    end

    def RubyBackup.strip_source_dir(file)
        file.gsub(@@config[:source_dir], '')
    end
end

RubyBackup::load_config

require_relative "rubybackup/filegatherer"
require_relative "rubybackup/filegroup"
require_relative "rubybackup/compress"
require_relative "rubybackup/uploaders3"
