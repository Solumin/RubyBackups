require "tmpdir"

require_relative "filegatherer"
require_relative "filegrouper"

# Set some things that will eventually be handled by configs/command line args
source_dir = "E:/My Documents"
dir_blacklist = %w(Desmume GitHub ISOs VBA-M).map {|d| File.join(source_dir, d) }
file_blacklist = []
ext_blacklist = %w(gb gba iso lnk nds)
ext_pattern = "*.{#{ext_blacklist.join(",")}}"

good_files = FileGatherer.gather(source_dir, dir_blacklist, file_blacklist, ext_blacklist)
puts FileGrouper.group(source_dir, good_files).keys
