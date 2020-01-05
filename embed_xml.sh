#!/bin/sh

DATUM=$(date +'%Y%m%d%H%M%S')

cat <<EOF > embed.ps
/XmlFileName	(zugferd-invoice.xml)				def
/XmlFileDesc	(Rechnungsdaten im ZUGFeRD-XML-Format)		def
/XmlFileDate	(D:$DATUM+01'00')			def
/XmlFileData	(zugferd-invoice.xml) (r) file		def



% istring SimpleUTF16BE ostring
/SimpleUTF16BE
{
	dup length
	1 add
	2 mul
	string
	
	% istring ostring
	dup 0 16#FE put
	dup 1 16#FF put
	2
	3 -1 roll

	% ostring index istring
	{
		% ostring index ichar
		3 1 roll
		% ichar ostring index
		2 copy 16#00 put
		1 add
		2 copy
		5 -1 roll
		% ostring index ostring index ichar
		put
		1 add
		% ostring index 
	}
	forall
	
	% ostring index 
	pop
}
bind def

 

% Object {ContentStream} anlegen und befüllen
[
	/_objdef 	{ContentStream}
	/type 		/stream
/OBJ pdfmark

[
	{ContentStream}	<<
			/Type		/EmbeddedFile
			/Subtype	(text/xml) cvn
			/Params		<<
					/ModDate	XmlFileDate
					>>
			>>
/PUT pdfmark
	
[
	{ContentStream}	XmlFileData
/PUT pdfmark

[
	{ContentStream}
/CLOSE pdfmark



% Object {FSDict} für File Specification anlegen und befüllen
[
	/_objdef	{FSDict}
	/type		/dict
/OBJ pdfmark

[
	{FSDict}	<<
			/Type 		/Filespec
			/F 		XmlFileName
			/UF 		XmlFileName SimpleUTF16BE
			/Desc		XmlFileDesc
			/AFRelationship	/Alternative
			/EF 		<<
					/F		{ContentStream}
					/UF		{ContentStream}
					>>
			>>
/PUT pdfmark



% Object {AFArray} für Associated Files anlegen und befüllen
[
	/_objdef	{AFArray}
	/type		/array
/OBJ pdfmark

[
	{AFArray}	{FSDict}
/APPEND pdfmark



% Associated Files im Object {Catalog} eintragen
[
	{Catalog}	<<
			/AF	{AFArray}
			>>
/PUT pdfmark



% File Specification unter Names/Embedded Files/Names im Object {Catalog} eintragen
[
	/Name		XmlFileName
	/FS		{FSDict}
/EMBED pdfmark
	


% Metadata im Object {Catalog} eintragen
[
	/XML		(

    <!-- XMP extension schema container for the zugferd schema -->
    <rdf:Description rdf:about=""
	xmlns:pdfaExtension="http://www.aiim.org/pdfa/ns/extension/"
	xmlns:pdfaSchema="http://www.aiim.org/pdfa/ns/schema#"
	xmlns:pdfaProperty="http://www.aiim.org/pdfa/ns/property#">
	
	<!-- Container for all embedded extension schema descriptions -->
	<pdfaExtension:schemas>
	    <rdf:Bag>
		<rdf:li rdf:parseType="Resource">
		    <!-- Optional description of schema -->
		    <pdfaSchema:schema>ZUGFeRD PDFA Extension Schema</pdfaSchema:schema>
		    <!-- Schema namespace URI -->
		    <pdfaSchema:namespaceURI>urn:ferd:pdfa:invoice:rc#</pdfaSchema:namespaceURI>
		    <!-- Preferred schema namespace prefix -->
		    <pdfaSchema:prefix>zf</pdfaSchema:prefix>
		    
		    <!-- Description of schema properties -->
		    <pdfaSchema:property>
			<rdf:Seq>!
			    <rdf:li rdf:parseType="Resource">
				<!-- DocumentFileName: Name of the embedded file;
				    must be equal with the value of the /F tag in the /EF
				    structure -->
				<pdfaProperty:name>DocumentFileName</pdfaProperty:name>
				<pdfaProperty:valueType>Text</pdfaProperty:valueType>
				<pdfaProperty:category>external</pdfaProperty:category>
				<pdfaProperty:description>name of the embedded xml invoice file</pdfaProperty:description>
			    </rdf:li>
			    <rdf:li rdf:parseType="Resource">
				<!-- DocumentType: INVOICE -->
				<pdfaProperty:name>DocumentType</pdfaProperty:name>
				<pdfaProperty:valueType>Text</pdfaProperty:valueType>
				<pdfaProperty:category>external</pdfaProperty:category>
				<pdfaProperty:description>INVOICE</pdfaProperty:description>
			    </rdf:li>
			    <rdf:li rdf:parseType="Resource">
				<!-- Version: The actual version of the
				    ZUGFeRD standard -->
				<pdfaProperty:name>Version</pdfaProperty:name>
				<pdfaProperty:valueType>Text</pdfaProperty:valueType>
				<pdfaProperty:category>external</pdfaProperty:category>
				<pdfaProperty:description>The actual version of the ZUGFeRD data</pdfaProperty:description>
			    </rdf:li>
			    <rdf:li rdf:parseType="Resource">
				<!-- ConformanceLevel: The actual conformance
					level of the ZUGFeRD standard,
					e.g. BASIC, COMFORT, EXTENDED -->
				<pdfaProperty:name>ConformanceLevel</pdfaProperty:name>
				<pdfaProperty:valueType>Text</pdfaProperty:valueType>
				<pdfaProperty:category>external</pdfaProperty:category>
				<pdfaProperty:description>The conformance level of the ZUGFeRD data</pdfaProperty:description>
			    </rdf:li>
			</rdf:Seq>
		    </pdfaSchema:property>
		</rdf:li>
	    </rdf:Bag>
	</pdfaExtension:schemas>
    </rdf:Description>
    
    <rdf:Description rdf:about="" xmlns:zf="urn:ferd:pdfa:invoice:rc#">
	<zf:DocumentType>INVOICE</zf:DocumentType>
	<zf:DocumentFileName>ZUGFeRD-invoice.xml</zf:DocumentFileName>
	<zf:Version>RC</zf:Version>
	<zf:ConformanceLevel>BASIC</zf:ConformanceLevel>
    </rdf:Description>
 
			)
/Ext_Metadata pdfmark



EOF
