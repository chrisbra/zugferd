# zugferd
a sample repository on how to create ZUGFeRD pdf files


This repository shows how to generated [ZUGFeRD](https://www.ferd-net.de/zugferd/definition/was-ist-zugferd.html)
invoices using [Apache-FOP](https://xmlgraphics.apache.org/fop/) and [ghostscript](https://www.ghostscript.com/)

# How to use it?

Well, in the ideal case, simply use:

```
make
```

The resulting generated file will be called `ZUGFeRD.pdf`

You might need to adjust the [fop.sh](https://github.com/chrisbra/zugferd/blob/master/fop.sh) shell script and point it
to the relevant path for the installation of java and fop (currently is uses a hardcoded path).

Also, ghostscript for some reason does not work with the native version on Windows. So you need to install the mingw
version of ghostscript using e.g. [MSYS2 pacman](https://github.com/msys2/msys2/wiki/Using-packages), e.g. install 64bit
ghostcript.

```
pacman -S mingw-w64-x86_64-ghostscript make
```
(this also installs make, which is needed to make use of the Makefile.


## What about ghostscript?

This repository uses Apache-FOP (XML Formatting Objects and XSLT) to create a pdf file. Although, theoretically, fop is able
to generate a PDF/A-1B compliant file, the ZUGFeRD Standard requires pdf files to be compliant to PDF/A-3. Therefore, use
ghostcript to create a compliant file. Unfortunately, this means, it has to embed an icc profile, therefore the
[PDFA_def.ps](https://github.com/chrisbra/zugferd/blob/master/PDFA_def.ps) is needed, which embeds the required
[AdobeRGB1998.icc](https://github.com/chrisbra/zugferd/blob/master/AdobeRGB1998.icc) color profile and embeds all fonts.

For attaching the required [zugferd-invoice.xml](https://github.com/chrisbra/zugferd/blob/master/zugferd-invoice.xml) an additional
piece of ghostscript is created, that embeds the XML file. (See [embed_xml.sh](https://github.com/chrisbra/zugferd/blob/master/embed_xml.sh)). 


# Copyright

Arial TTF files are ©️ by Microsoft, the AdobeRGB1998.icc is ©️  Adobe, the embed_xml.ps comes from the [ghostscript Bugtracker](https://bugs.ghostscript.com/show_bug.cgi?id=696472)

The rest is licensed MIT.
