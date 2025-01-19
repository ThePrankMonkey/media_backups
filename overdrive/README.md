## Issues

### ODM Link is gone from Overdrive

https://gist.github.com/ping/b58ae66359691db1d08f929a9e57a03d

```plain
javascript:(function()%7B%2F*%201.%20Paste%20this%20entire%20gist%20over%20at%20https%3A%2F%2Fmrcoles.com%2Fbookmarklet%2F%20to%20generate%20a%20bookmarklet%20*%2F%2F*%202.%20Use%20a%20meaningful%20Name%20like%3A%20%F0%9F%8E%A7%20%F0%9F%93%96%20Links%20*%2F%2F*%203.%20Drag%20the%20generated%20bookmarklet%20link%20to%20your%20Bookmarks%20Toolbar.%20*%2F%2F*%204.%20Click%20on%20the%20bookmarklet%20when%20you're%20on%20the%20Overdrive%20loan%20page%2C%20e.g.%20https%3A%2F%2Fyourlibrary.overdrive.com%2Faccount%2Floans%20*%2F%2F*%205.%20The%20%22Download%20MP3%20audiobook%22%20link%20should%20appear%20like%20it%20used%20to.%20*%2F%24('a%5Bdata-format-id%3D%22audiobook-overdrive%22%5D').each(function()%20%7Bvar%20listenBtn%20%3D%20%24(this)%3Bif%20(listenBtn.hasClass('script-added'))%20%7BlistenBtn.remove()%3Breturn%3B%7Dvar%20dlBtn%20%3D%20listenBtn.clone()%3BdlBtn.attr('class'%2C%20'loan-button-nonkindle%20button%20radius%20primary%20downloadButton%20script-added')%3BdlBtn.attr('href'%2C%20dlBtn.attr('href').replace('%2Faudiobook-overdrive%2F'%2C%20'%2Faudiobook-mp3%2F'))%3BdlBtn.html('%3Cb%3EDownload%3C%2Fb%3E%3Cbr%2F%3E%3Cspan%20class%3D%22dl-text%22%3EMP3%20audiobook%3C%2Fspan%3E')%3BdlBtn.attr('target'%2C%20'')%3BlistenBtn.parent().append(dlBtn)%3B%7D)%7D)()
```

### Knock repo is... missing

I was able to yank some archived back ups of `knock` v1.2. I also grabbed `overdrive.sh` just incase that disappears as well.

Updated the Dockerfile to copy in this archived versions and things are back up and running fine.

I also found newer versions of `knock`, but "if it ain't broke don't fix it" so I haven't tested with them yet.
