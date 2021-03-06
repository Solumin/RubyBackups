# Ruby Backups

A small utility for backing up a directory to something like Amazon S3. It takes
a source directory (or directories, eventually) and blacklists for
(sub)directories, files and extensions. These are used to determine which files
to backup.

The utility consists of a few components:

- File Gatherer: Takes the source directory path and the blacklists and returns
  a list of all valid files in the source directory

- File Grouper: Takes the source directory path and the list of files and
  returns a hash that maps the top-level subdirectory name to the list of files
  in that subdirectory. (e.g. ~ is source dir, ['~/foo/bar1', '~/foo/bar2']
  returns ["foo" => ["~/foo/bar1", "~/foo/bar2"])

- Compressor: Takes a list of files and returns an IO object representing a
  the compressed archive of the files.

- Uploader: Takes a target name (e.g. "files.zip") and an IO object, then stores
  the IO object under the given name.

The workflow of the utility should be pretty obvious: gather -> group ->
[compress -> upload].

This utility is NOT intended to be a full backup solution. No integrity
checking, no automating backups, probably no incremental backups. Keeping It
Simple with just "compress these files and upload." It doesn't even fetch and
unpack the backups for you!

**Required Gems:** aws-sdk, rubyzip

**Configuring:**

- config/config.yml: Should be a YAML file in the following format:
```yaml
    :AWS_config: {
        access_key_id: <YOUR AWS ACCESS KEY>
        secret_access_key: <YOUR AWS SECRET KEY>
        }

    :source_dir: <YOUR SOURCE DIR>
    :dir_blacklist:
        - <LIST OF DIRECTORIES>
    :file_blacklist:
        - <LIST OF FILES>
    :ext_blacklist:
        - <LIST OF EXTENSIONS>
    
```

**Running:**

After configuring, run the app through the file in the bin/ directory:
```
    ruby bin/rubybackup
```

TODO:

- Process for "initializing" the utility, making first config file

- Consider concurrent approach, e.g. compressing and uploading in parallel.

- Support multiple compression formats.
  (via Compressor API of some kind -- allow multiple compressor modules)

- Support uploading to S3, local network, external hard drive.
  (via Uploader API of some kind -- multiple upload modules.)

- More comprehensive error handling and logging.

- User Interface, both CLI and GUI.

- Restoring from backup
