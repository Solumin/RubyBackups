module FileGrouper
    module_function

    def group(source_dir, filelist)
        group_pattern = /#{source_dir}#{File::Separator}([^#{File::Separator}]+)/
        s = singles(source_dir, filelist)
        zip_groups = (filelist - s).group_by { |f| f.match(group_pattern)[1] }
        zip_groups["FILEZ"] = s.dup
        return zip_groups
    end

    def singles(source_dir, filelist)
        src_count = (source_dir.count File::Separator) + 1
        filelist.select { |f| f.count(File::Separator) == src_count }
    end
    private :singles

end
