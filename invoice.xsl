<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <!-- Attribut-Sets fuer Tabellenzellen -->
  <xsl:attribute-set name="cell-style">
    <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-color">black</xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="block-style">
    <xsl:attribute name="font-size">  10pt</xsl:attribute>
    <xsl:attribute name="line-height">15pt</xsl:attribute>
    <xsl:attribute name="start-indent">1mm</xsl:attribute>
    <xsl:attribute name="end-indent">  1mm</xsl:attribute>
  </xsl:attribute-set>
  <xsl:decimal-format name="westeuropa" decimal-separator=',' grouping-separator='.' />

  <xsl:template match="/">
    <fo:root font-family="Arial">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="DIN-A4" margin="15mm 25mm 30mm 15mm" page-height="297mm" page-width="210mm">
          <fo:region-body margin="20mm 0mm 20mm 0mm"/>
          <fo:region-before region-name="header" extent="30mm" />
          <fo:region-after region-name="footer" extent="30mm" />
          <fo:region-start  region-name="left"   extent="10mm"/>
          <fo:region-end    region-name="right"  extent="10mm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
        <fo:declarations>
				<x:xmpmeta xmlns:x="adobe:ns:meta/">
					<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
						<rdf:Description rdf:about=""
								xmlns:dc="http://purl.org/dc/elements/1.1/">
							<!-- Dublin Core properties go here -->
							<dc:title>ZUGFeRD elektronische Rechnung</dc:title>
							<dc:creator>EAI</dc:creator>
							<dc:description>Rechnung</dc:description>
						</rdf:Description>
						<rdf:Description rdf:about=""
								xmlns:xmp="http://ns.adobe.com/xap/1.0/">
							<!-- XMP properties go here -->
							<xmp:CreatorTool>Apache FOP</xmp:CreatorTool>
						</rdf:Description>
					</rdf:RDF>
				</x:xmpmeta>
			</fo:declarations>
      <fo:page-sequence master-reference="DIN-A4">
        <fo:static-content flow-name="header">
          <fo:block font-size="18pt" text-align="center">
            Beispiel Rechnung Nr <xsl:value-of select="//ExchangedDocument/ID"/>
          </fo:block>
        </fo:static-content>
        <fo:static-content flow-name="footer">
          <fo:block font-size="10pt" text-align="center">
            <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="2pt"/>
            Wir freuen uns darauf, mit Ihnen Geschäfte zu machen.
          </fo:block> 
          <fo:block font-size="8pt" text-align="center" margin-top="10mm">
              <xsl:value-of select="//IncludedNote[last()]/Content"/>
          </fo:block> 
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body" font-size="11pt">
            <!-- <xsl:apply-templates/> -->
          <fo:block-container font-size="11pt" margin-left="5mm" margin-bottom="5mm" text-align="left">
            <fo:block>
              Lieferung an <xsl:value-of select="//BuyerTradeParty/Name"/>
            </fo:block>
          </fo:block-container>
          <xsl:call-template name="Notizen"/>
          <xsl:call-template name="Lieferungen"/>
          <fo:block-container font-size="11pt" margin-left="5mm" margin-bottom="5mm" margin-top="10mm" text-align="right">
            <fo:block linefeed-treatment="preserve">
              Summe: <xsl:value-of select="format-number(//LineTotalAmount, '##.00 EUR')"/>
               MwSt: <xsl:value-of select="format-number(//TaxTotalAmount, '##.00 EUR')"/>
            </fo:block>
            <fo:block>
              <fo:leader leader-pattern="rule" leader-length="40mm" rule-style="solid" rule-thickness="2pt"/>
            </fo:block>
            <fo:block font-weight="bold">
              Gesamt: <xsl:value-of select="format-number(//DuePayableAmount, '##.00 EUR')"/>
            </fo:block>
          </fo:block-container>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

   <!-- Notes Root-Element-Template -->
  <xsl:template match="/CrossIndustryInvoice/ExchangedDocument/IncludedNote" name="Notizen">
    <xsl:for-each select="//Content">
      <fo:block-container font-size="11pt" margin-left="5mm" margin-bottom="5mm" text-align="left">
        <fo:block linefeed-treatment="preserve">
          <xsl:value-of select="."/>
        </fo:block>
      </fo:block-container>
    </xsl:for-each>
	</xsl:template>


  <!-- Tabellenkopf -->
  <xsl:template name="table-head">
    <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style" text-align="center" font-weight="bold">Nr</fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style" text-align="center" font-weight="bold">Art. Nr</fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style" text-align="center" font-weight="bold">Beschreibung</fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style" text-align="center" font-weight="bold">Nettopreis</fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style" text-align="center" font-weight="bold">Menge</fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style" text-align="center" font-weight="bold">MwSt.</fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style" text-align="center" font-weight="bold">Betrag</fo:block>
        </fo:table-cell>
    </fo:table-row>
  </xsl:template>


  <!-- Lieferungen -->
  <xsl:template name="Lieferungen"  match="//IncludedSupplyChainTradeTransaction">
    <fo:table border-style="solid" width="100%" margin-top="10mm">
        <fo:table-column/>
        <fo:table-column/>
        <fo:table-column/>
        <fo:table-column/>
        <fo:table-column/>
        <fo:table-column/>
        <fo:table-column/>
        <fo:table-header>
          <xsl:call-template name="table-head"/>
        </fo:table-header>
        <fo:table-body>
          <xsl:call-template name="Items"/>
        </fo:table-body>
    </fo:table>
  </xsl:template>

  <!-- Template der 'Lineitems'-Elemente -->
  <xsl:template name="Items" match="//IncludedSupplyChainTradeLineItem">
    <xsl:for-each select="//IncludedSupplyChainTradeLineItem">
      <fo:table-row>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style">
            <xsl:value-of select="AssociatedDocumentLineDocument/LineID"/>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style">
            <xsl:value-of select="SpecifiedTradeProduct/GlobalID"/>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style">
            <xsl:value-of select="SpecifiedTradeProduct/Name"/>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style">
            <xsl:value-of select="SpecifiedLineTradeAgreement/NetPriceProductTradePrice/ChargeAmount"/>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style">
            <xsl:value-of select="SpecifiedLineTradeDelivery/BilledQuantity"/>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style">
            <xsl:value-of select="SpecifiedLineTradeSettlement/ApplicableTradeTax/RateApplicablePercent"/>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell xsl:use-attribute-sets="cell-style">
          <fo:block xsl:use-attribute-sets="block-style">
            <xsl:value-of select="SpecifiedLineTradeAgreement/GrossPriceProductTradePrice/ChargeAmount"/>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
