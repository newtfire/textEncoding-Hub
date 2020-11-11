<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <html>
           <head>
               <title>Lists of Places in the Mitford Site Index</title>
           </head>
            <body>            
                
               <ol> 
                   <xsl:apply-templates select="descendant::listPlace"/> 
               
             </ol> 
            </body>
  
        </html>
    </xsl:template>
    
    <xsl:template match="listPlace">
        <li><xsl:value-of select="@sortKey"/>
            <ul><xsl:apply-templates select="child::place"/></ul>
        
        </li>
        
    </xsl:template>
    
    <xsl:template match="place">
        <li><xsl:apply-templates select="descendant::placeName[1]"/></li>
        
    </xsl:template>
    
    
</xsl:stylesheet>