OUTPUT=ZUGFeRD.pdf
INPUT=zugferd-invoice.xml

all: pdf

clean:
	rm -f *.pdf embed.ps

dist-clean: clean

# Note for tuning PDF Size, you can use the -dPDFSETTINGS=<configuration> parameter
# <configuration> can be one of:
# /screen   selects low-resolution output similar to the Acrobat Distiller (up to version X) “Screen Optimized” setting.
# /ebook    selects medium-resolution output similar to the Acrobat Distiller (up to version X) “eBook” setting.
# /printer  selects output similar to the Acrobat Distiller “Print Optimized” (up to version X) setting.
# /prepress selects output similar to Acrobat Distiller “Prepress Optimized” (up to version X) setting.
# /default  selects output intended to be useful across a wide variety of uses, possibly at the expense of a larger output file.
#
# See also 
# - https://ghostscript.readthedocs.io/en/latest/VectorDevices.html#controls-and-features-specific-to-postscript-and-pdf-input
# - https://askubuntu.com/a/256449
pdf: $(INPUT)
	./fop.sh -c fop.xconf -xsl invoice.xsl -xml $< -pdf zugferd_generated.pdf
	./embed_xml.sh
	PATH=/mingw32/bin:$(PATH) gs -dPDFA=3 -dBATCH -dNOPAUSE -sColorConversionStrategy=RGB -sProcessColorModel=DeviceRGB -dPDFACompatibilityPolicy=3 -sDEVICE=pdfwrite -sOutputFile=$(OUTPUT) PDFA_def.ps embed.ps  zugferd_generated.pdf 
