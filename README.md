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

- Compressor: Takes an archive name and a list of files to include and creates a
  compressed archive in a temp directory. Returns the name of the archive.  
  (Not yet implemented.)

- Uploader: Takes a list of files to upload and, uh, uploads them.  
  (Not yet implemented.)

The workflow of the utility should be pretty obvious: gather -> group ->
compress -> upload.

This utility is NOT intended to be a full backup solution. No integrity
checking, no automating backups, probably no incremental backups. Keeping It
Simple with just "compress these files and upload."

TODO:

- Finish implementation of Uploader

- Consider concurrent approach, e.g. compressing and uploading in parallel.

- Support multiple compression formats.
  (via Compressor API of some kind -- allow multiple compressor modules)

- Support uploading to S3, local network, external hard drive.
  (via Uploader API of some kind -- multiple upload modules.)

- More comprehensive error handling and logging.

- User Interface, both CLI and GUI.
