require 'zip'

module RubyBackup
    # Compress takes a list of files (fully qualified paths) and
    # returns a StringIO that represents a compressed .zip archive of those files.
    module ZipCompression
        module_function

        def compress(files)
            comp = Zip::OutputStream::write_buffer do |zstream|
                files.each do |file|
                    zstream.put_next_entry strip_source_dir(file)
                    zstream.write File.new(file).read
                end
            end
            comp.rewind
            yield comp if block_given?
            return comp
        end

        # Strips the leading source_directory prefix from a file's path
        def strip_source_dir(file)
            file.gsub(RubyBackup::source_dir + File::Separator, '')
        end
        private_class_method :strip_source_dir
    end
end
