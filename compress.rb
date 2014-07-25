require 'zip'

module RubyBackup
    # Compression process:
    # 1. Main creates temp dir for storying archives until upload
    # 2. Main sends archive-file pairs to compresser():
    # def compresser(archive, files)
    # 3. Compressor compresses file list into the archive
    # 4. Compressor returns full path of compressed archive.
    #
    # Note that the full path is preserved in the compressed files.


    # Compress takes a list of files (fully qualified?) and
    # returns a StringIO that represents a compressed .zip archive of those files.
    def compress(files)
        comp = Zip::OutputStream::write_buffer do |zstream|
            files.each do |file|
                zstream.put_next_entry file
                zstream.write File.new(file).read
            end
        end
        comp.rewind
        yield comp if block_given?
        return comp
    end
end
