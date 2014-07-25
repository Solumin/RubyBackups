module RubyBackup
    module FileGroup
        module_function

        def group(source_dir, filelist)
            group_pattern = /#{source_dir}#{File::Separator}([^#{File::Separator}]+)/
            s = singles(source_dir, filelist)
            zip_groups = (filelist - s).group_by { |f| f.match(group_pattern)[1] }
            zip_groups.each_pair do |dir, files|
                files.map! {|f| f.sub File.join(source_dir, dir, ''), '' }
            end
            zip_groups[""] = s.map { |f| f.sub File.join(source_dir, ''), '' }
            return zip_groups
        end

        def singles(source_dir, filelist)
            src_count = (source_dir.count File::Separator) + 1
            filelist.select { |f| f.count(File::Separator) == src_count }
        end
        private :singles

    end
end
