require_relative "rubybackup/filegatherer"
require_relative "rubybackup/filegroup"
require_relative "rubybackup/compress"
require_relative "rubybackup/uploaders3"

require "yaml"

module RubyBackup
    @@config = {:app_dir => Dir.pwd}
    def RubyBackup.config(config_file = File.join(Dir.pwd, "config/config.yml"))
        @@config = YAML.load_file(config_file)
        @@config[:ext_pattern] = "*.{#{@@config[:ext_blacklist].join(",")}}"
    end

    def strip_source_dir(file)
        file.gsub(@@config[:source_dir], '')
    end
end

RubyBackup::config
