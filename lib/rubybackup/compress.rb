require 'zip'

module RubyBackup
    # Compression process:
    # 1. Main sends archive-file pairs to compresser():
    # def compresser(archive, files)
    # 2. Compressor compresses file list into an in-memory (stream) archive
    # 3. Compressor returns a StringIO of the stream
    #
    # Note that the full path below source_dir is preserved in the compressed files.

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
