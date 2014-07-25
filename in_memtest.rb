require "zip"
require "aws-sdk"
require "yaml"

file = "don_quixoteI.txt"

comp = Zip::OutputStream::write_buffer do |zstream|
    zstream.put_next_entry file
    zstream.write File.new("testdir/#{file}").read
end

comp.rewind

puts "Do you want to upload the test file to S3? (Y/N)"

if STDIN.gets.match(/^[Yy]/)
    AWS.config(YAML.load_file("config.yml"))

    s3 = AWS::S3.new
    bucket_name = "test_up"
    bucket_name = "tsudol.#{bucket_name}-backup.#{Date.today.strftime("%Y.%m.%d")}"

    bucket = s3.buckets.create(bucket_name)

    bucket.objects[file].write(comp)
else
    puts "Upload canceled"
end
