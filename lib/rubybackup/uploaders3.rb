require "aws-sdk"
require "yaml"

module RubyBackup
    def upload_init
        AWS.config(RubyConfig::config[:AWS_config])
    end

    def upload(source_dir, archive_paths)
        s3 = AWS::S3.new
        bucket_name = File.basename(RubyBackup::source_dir).downcase.sub(/[^a-z0-9\-]/, '-')
        bucket_name = "tsudol.#{bucket_name}-backup.#{Date.today.strftime("%Y.%m.%d")}"

        bucket = s3.buckets.create(bucket_name)

        archive_paths.each {|a| bucket.objects[File.basename(a)].write(:file => a) }
    end
end
