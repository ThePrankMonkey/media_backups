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

## Resources

- https://github.com/chbrown/overdrive
