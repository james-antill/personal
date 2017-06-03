#! /bin/sh -e

rpm -q --queryformat '%{NAME}-%{EPOCH}:%{VERSION}-%{RELEASE}.%{ARCH}:\n'\
'[%{FILEMODES:perms} %{FILEUSERNAME} %{FILEGROUPNAME} %{FILESIZES} %{FILENAMES}\
  Lang: %{FILELANGS}\
  Mtime: (%{FILEMTIMES}) %{FILEMTIMES:date}\
  Dev: %{FILERDEVS:hex}\
  %|FILEFLAGS?{Flags: (%{FILEFLAGS:hex}) %{FILEFLAGS:fflags}}:{}|\
  Digest: %{FILEMD5S}\
  %|FILELINKTOS?{Link to: %{FILELINKTOS}}:{}|\
  Verify: (%{FILEVERIFYFLAGS:hex}) %{FILEVERIFYFLAGS:vflags}\n]' $@
