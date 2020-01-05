OUTPUT=ZUGFeRD.pdf
INPUT=zugferd-invoice.xml

all: pdf

clean:
	rm -f *.pdf embed.ps

dist-clean: clean

pdf: $(INPUT)
	./fop.sh -c fop.xconf -xsl invoice.xsl -xml $< -pdf zugferd_generated.pdf
	./embed_xml.sh
	PATH=/mingw32/bin:$(PATH) gs -dPDFA=3 -dBATCH -dNOPAUSE -sColorConversionStrategy=RGB -sProcessColorModel=DeviceRGB -dPDFACompatibilityPolicy=3 -sDEVICE=pdfwrite -sOutputFile=$(OUTPUT) PDFA_def.ps embed.ps  zugferd_generated.pdf 
