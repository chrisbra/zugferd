#!/bin/sh

# If you need to embed files into a pdf document, make sure to generate the
# xml files to each corresponding included ttf file.
#
# An example on how to do this on Debian for Arial and Arial bold shown below:
# (needs of course java, fop and fontbox installed)

java -classpath /usr/share/java/commons-io.jar:/usr/share/java/avalon-framework.jar:/usr/share/java/serializer.jar:/usr/share/java/xalan2.jar:/usr/share/java/xml-apis.jar:/usr/share/java/batik-all.jar:/usr/share/java/commons-logging.jar:/usr/share/java/xercesImpl.jar:/usr/share/java/xmlgraphics-commons.jar:/usr/share/java/xml-apis-ext.jar:/usr/share/java/fontbox.jar:/usr/share/fop/fop-hyph.jar:/usr/share/java/fop.jar  org.apache.fop.fonts.apps.TTFReader -enc ansi arial.ttf arial.xml
java -classpath /usr/share/java/commons-io.jar:/usr/share/java/avalon-framework.jar:/usr/share/java/serializer.jar:/usr/share/java/xalan2.jar:/usr/share/java/xml-apis.jar:/usr/share/java/batik-all.jar:/usr/share/java/commons-logging.jar:/usr/share/java/xercesImpl.jar:/usr/share/java/xmlgraphics-commons.jar:/usr/share/java/xml-apis-ext.jar:/usr/share/java/fontbox.jar:/usr/share/fop/fop-hyph.jar:/usr/share/java/fop.jar  org.apache.fop.fonts.apps.TTFReader -enc ansi arialbd.ttf arialbd.xml
