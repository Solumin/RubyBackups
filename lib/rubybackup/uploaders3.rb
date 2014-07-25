require "aws-sdk"
require "yaml"

module RubyBackup
    module S3Upload
        module_function
        def upload_init
            AWS.config(RubyBackup::config[:AWS_config])
            @@s3 = AWS::S3.new
            bucket_dir = File.basename(RubyBackup::source_dir).downcase.sub(/[^a-z0-9\-]/, '-')
            @@bucket_name = "tsudol.#{bucket_dir}-backup.#{Date.today.strftime("%Y.%m.%d")}"
            @@bucket = @@s3.buckets.create(@@bucket_name)
        end

        # It takes not a file name, but an IO-like object for zip_content
        def upload_file(name, zip_content)
            @@bucket.objects[name].write(zip_content)
        end
    end
end
