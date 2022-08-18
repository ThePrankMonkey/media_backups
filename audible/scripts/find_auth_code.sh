#! /bin/bash
ffprobe /Audiobooks/Some_File.aax | grep "[aax] file checksum =="
# Look up the checksum
cd /usr/app/inaudible-tables
./rcrack . -h $CHECKSUM | grep "hex:"
cd -