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

Knock can handle everything for us to convert `.ascm` to `.epub`.

```bash
docker-compose exec overdrive knock YOUR_BOOK.ascm
```

## Backing up Audible Audiobooks

So, downloading audible is easy enough. Just on PC go in and grab the download files. The problem is that Audible downloads a DRMed `AAX` file. To decrypt back to `MP3`, we need to find our `AUTHCODE`. I've found two approaches for getting it, but it should only need to be ran once per user regardless. Then it'll just be decrypting.

### Get AUTHCODE

We need to get your AUTHCODE off of one of your audible books. This is unique per account. After placing one of your `.AAX` files into `./audible/audiobooks`, run the following:

```bash
docker-compose exec audible find_auth_code SOME_FILE.aax
```

Now update the `.env` in the same folder as `docker-compose.yaml` to look like the following, replacing YOUR_HEX with what you just found.

```plain
AUTHCODE=YOUR_HEX
```

Then restart the compose with `docker-compose up -d`.

### Decrypt AAX

```bash
docker-compose exec audible convert_aax SOME_FILE.aax
```

## Backing up Kindle Books

1. Download and install an older version of Kindle for Windows (`KindleForPC-installer-1.17.44170.exe`).
   - This is so you get the older AZW format.
2. Download the book you want.
3. Extract it from local copy: `C:\Users\UserName\Documents\My Kindle Content`
4. Find decryption key for local Windows machine.
   - https://github.com/apprenticeharper/DeDRM_tools/blob/master/Other_Tools/DRM_Key_Scripts/Kindle_for_Mac_and_PC/kindlekey.pyw
5. Update configs.
6. Dedrm by adding to calibre:
   - `calibredb add --with-library ./library <FILE.AZW>`
   - Might be able to just convert the AZW directly with `ebook-convert <FILE.AZW> <FILE.EPUB>` or whatever extension you want.
     - For PDF, need to run as non-root.

```bash
docker-compose exec kindle bash
cd /Ebooks
calibredb add --with-library ./library <FILE.AZW>
```

```bash
docker-compose exec kindle bash
cd /Ebooks
su - fart -c "bash"
ebook-convert <FILE.AZW> /tmp/<FILE.EPUB>
ebook-convert <FILE.AZW> /tmp/<FILE.PDF>
exit
mv /tmp/*.pdf .
mv /tmp/*.epub .
```

## Problems

### Problem - mp4v2-utils not in newest Ubuntu

Gotta install from an older version.

- https://packages.ubuntu.com/bionic/amd64/libmp4v2-2/download
- https://packages.ubuntu.com/bionic/amd64/mp4v2-utils/download

### Problem - some books have the same title but different subtitles...

Like with the _Learn German with Stories_ series, all of the books keep overwriting each other because they have the same **Title**. But I should be able to add a **Subtitle** to the folder name. The `overdrive` binary doesn't seem to let me change the output structure (look into updating that...). But I can take a look at `<ODM>.metadata` and grab the values I want with `xml.etree.ElementTree`.

```xml
<Metadata>
	<ContentType>MP3 Audio Book</ContentType>
	<Title>Learn German with Stories</Title>
	<SubTitle>Digital in Dresden: 10 Short Stories for Beginners</SubTitle>
	<SortTitle>Learn German with Stories Digital in Dresden 10 Short Stories for Beginners</SortTitle>
	<Series>Dino lernt Deutsch</Series>
	<Publisher>learnoutlive</Publisher>
	<ThumbnailUrl>https://images.contentreserve.com/ImageType-200/7552-1/{2483D474-479C-4981-9381-380649157F08}Img200.jpg</ThumbnailUrl>
	<CoverUrl>https://images.contentreserve.com/ImageType-100/7552-1/{2483D474-479C-4981-9381-380649157F08}Img100.jpg</CoverUrl>
	<Creators>
		<Creator role="Author" file-as="Klein, Andr&#233;">Andr&#233; Klein</Creator>
		<Creator role="Narrator" file-as="Klein, Andr&#233;">Andr&#233; Klein</Creator>
	</Creators>
	<Subjects>
		<Subject id="28">Foreign Language Study</Subject>
		<Subject id="111">Nonfiction</Subject>
	</Subjects>
	<Languages>
		<Language code="de">German</Language>
	</Languages>
<Description>&lt;p&gt;Experience the &lt;strong&gt;ninth episode&lt;/strong&gt; of the &lt;strong&gt;Dino lernt Deutsch&lt;/strong&gt; &lt;strong&gt;story series for German learners&lt;/strong&gt; on your stereo or headphones, at home or on the go!&lt;/p&gt;&lt;br /&gt;&lt;p&gt;Dino lands a promising new office job in Dresden with stable pay and promotion opportunities, but it's only so long before corporate implications force him to make a tough decision.&lt;/p&gt;&lt;br /&gt;&lt;p&gt;The narration speed and style of this audiobook is aimed at beginners and intermediates, with special emphasis on clear pronunciation, so that you can easily pause and repeat words and phrases whenever you please.&lt;/p&gt;&lt;br /&gt;&lt;p&gt;(To get the most out of this audiobook we recommend listening while reading through a paperback or ebook edition of "Learn German with Stories: Digital in Dresden &#8211; 10 Short Stories for Beginners" and working through the exercises.)&lt;/p&gt;&lt;br /&gt;&lt;p&gt;Playing time: 1:32:21&lt;/p&gt;&lt;br /&gt;&lt;p&gt;Written and narrated by Andr&#233; Klein&lt;/p&gt;&lt;br /&gt;&lt;p&gt;Copyright 2019, learnoutlive.com&lt;/p&gt;</Description>
</Metadata>
```

Diving deeper in the `overdrive` binary, I see a [section](https://github.com/chbrown/overdrive/blob/master/overdrive.sh#L38) that should allow me to modify the folder structure. And if I use the `--output` param after making changes in this [section](https://github.com/chbrown/overdrive/blob/master/overdrive.sh#L301-L302) I can leverage more replacement words. I'll just need to create extractors for any new term.

## Resources

- https://github.com/chbrown/overdrive
- https://github.com/KrumpetPirate/AAXtoMP3
- https://blog.dtpnk.tech/en/howto/convert_audible_to_mp3/#
- [inAudible-NG's audible-activator](https://github.com/inAudible-NG/audible-activator) looks to pull your audible `AUTHCODE` from the browser.
- [inAudible-NG's tables](https://github.com/inAudible-NG/tables) looks to use a rainbow table to hack your `AUTHCODE` due to collision.
- https://github.com/mkb79/audible-cli
- https://github.com/openaudible/openaudible, junk ignore this.
- https://www.cloudwards.net/remove-drm-from-kindle-books/
  - https://github.com/apprenticeharper/DeDRM_tools/releases
- https://github.com/BentonEdmondson/knock
