# Backing Up Media

I buy a lot of media, and I don't trust it to always be available. Here's some tools to back all of that up.

## Backing up Overdrive Audiobooks

Overdrive (now Libby) got rid of the desktop client. But _chbrown_ created a script that downloads MP3s if you can get the odm file.

1. Go to a library page, like https://nypl.overdrive.com/
1. Borrow a book.
1. Click "Do you have the OverDrive app?" and it'll give you a link to an ODM file.
1. Toss that into the volume mounted `./overdrive/audiobooks` and you can run the following command:

```bash
docker-compose exec overdrive overdrive download YOUR_BOOK.odm
```

## Backing up Audible Audiobooks

**TBD**
So, downloading audible is easy enough. Just on PC go in and grab the download files. The problem is that Audible downloads a DRMed `AAX` file. To decrypt back to `MP3`, we need to find our `AUTHCODE`. I've found two approaches for getting it, but it should only need to be ran once per user regardless. Then it'll just be decrypting.

```bash
# Grab the checksum
ffprobe /Audiobooks/Some_File.aax
# look for "[aax] file checksum ==" near the top of the output

# Look up the checksum
export CHECKSUM=YOUR_CHECKSUM
cd /usr/app/inaudible-tables
./rcrack . -h $CHECKSUM | grep "hex:"
# The information after hex is what you want.
```

```bash
export AUTHCODE=YOUR_CODE
docker-compose exec audible AAXtoMP3 --aac --chaptered --authcode $AUTHCODE /Audiobooks/SOME_FILE.aax
```

## Problems

### Problem - mp4v2-utils not in newest Ubuntu

Gotta install from an older version.

- https://packages.ubuntu.com/bionic/amd64/libmp4v2-2/download
- https://packages.ubuntu.com/bionic/amd64/mp4v2-utils/download

## Resources

- https://github.com/chbrown/overdrive
- https://github.com/KrumpetPirate/AAXtoMP3
- https://blog.dtpnk.tech/en/howto/convert_audible_to_mp3/#
- [inAudible-NG's audible-activator](https://github.com/inAudible-NG/audible-activator) looks to pull your audible `AUTHCODE` from the browser.
- [inAudible-NG's tables](https://github.com/inAudible-NG/tables) looks to use a rainbow table to hack your `AUTHCODE` due to collision.
- https://github.com/mkb79/audible-cli
- https://github.com/openaudible/openaudible, junk ignore this.
