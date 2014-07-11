# Compression process:
# 1. Main creates temp dir for storying archives until upload
# 2. Main sends archive-file pairs to compresser():
# def compresser(archive, files)
# 3. Compressor compresses file list into the archive
# 4. Compressor returns full path of compressed archive.
#
# Note that the full path is preserved in the compressed files.

require "zip"

def compress(archive, dir, files)
    Zip::File.open(archive, 'w') do |zipfile|
        files.each { |f| zipfile.add(f, File.join(dir, f)) }
    end
    return archive
end
