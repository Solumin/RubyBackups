module RubyBackup
    module FileGroup
        module_function

        def group(filelist)
            source_dir = RubyBackup::source_dir
            group_pattern = /#{source_dir}#{File::Separator}([^#{File::Separator}]+)/

            s = singles(filelist)

            zip_groups = (filelist - s).group_by { |f| f.match(group_pattern)[1] }
            zip_groups[""] = s
            return zip_groups
        end

        def singles(filelist)
            src_count = (RubyBackup::source_dir.count File::Separator) + 1
            filelist.select { |f| f.count(File::Separator) == src_count }
        end
        private :singles
    end
end
