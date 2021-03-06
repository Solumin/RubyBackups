require "find"
module RubyBackup
    class FileGatherer
        attr_reader :source_dir, :dir_blacklist, :file_blacklist, :ext_blacklist

        # src is the source directory that files will be grouped from
        # dirs and files are arrays of fully-qualified files that have src as the
        # prefix
        # exts is an array of file extensions, e.g. ['txt', 'jpg']
        # dirs, files and exts are used to filter out files from the source
        # directory
        def initialize(src, dirs, files, exts, extp = nil)
            @source_dir = src
            @dir_blacklist = dirs
            @file_blacklist = files
            @ext_blacklist = exts
            @ext_pattern = extp or "*.{#{@ext_blacklist.join(",")}}"
            @files = nil
        end

        # If files have already been gathered, this will return just the files
        # (i.e. the cached result)
        # Otherwise it calls gather! which will always recompute the file list
        # TODO: Make sure gather and gather! have the same behavior re: blocks
        def gather
            if @files.nil? or files.empty?
                gather!
            else
                @files
            end
        end
        # Fake an attr_reader for @files
        alias_method :files, :gather

        # TODO: yield/block, enumerator?
        # Forces computation of file list
        # Walks the filetree using Ruby's Find from stdlib.
        def gather!
            @files = []
            Find.find(source_dir) do |path|
                Find.prune if FileTest.directory?(path) and @dir_blacklist.include?(path)
                next if FileTest.symlink? path
                if FileTest.file? path
                    next if @file_blacklist.include? path
                    next if File.fnmatch?(@ext_pattern, path, File::FNM_EXTGLOB)
                    @files << path
                end
            end
            return @files
        end

        def self.directory_info
            RubyBackup::config.values_at(:source_dir, :dir_blacklist,
                                          :file_blacklist, :ext_blacklist, :ext_pattern)
        end
        private_class_method :directory_info

        # Transparent class method of gather
        def self.gather
            self.new(*directory_info).gather
        end
    end
end
