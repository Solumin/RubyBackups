require "tmpdir"

require_relative "filegatherer"
require_relative "filegroup"
require_relative "compress"

# Set some things that will eventually be handled by configs/command line args
source_dir = "E:/My Documents"
dir_blacklist = %w(Desmume GitHub ISOs VBA-M).map {|d| File.join(source_dir, d) }
file_blacklist = []
ext_blacklist = %w(gb gba iso lnk nds)
ext_pattern = "*.{#{ext_blacklist.join(",")}}"

good_files = FileGatherer.gather(source_dir, dir_blacklist, file_blacklist, ext_blacklist)
groups = FileGroup.group(source_dir, good_files)

archive_dir = Dir.mktmpdir("Backup")
groups.each_pair do |name, files|
    dir = File.join(source_dir, name)
    archive = "#{File.join(archive_dir, name.empty? ? "FILEZ" : name)}.zip"
    puts compress(archive, dir, files)
end

FileUtils.remove_entry archive_dir
