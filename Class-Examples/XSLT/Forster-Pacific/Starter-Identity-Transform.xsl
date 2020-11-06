<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs math xd"
    version="3.0">
 <!--   <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 6, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> eeb4</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>-->
    
    <xsl:mode on-no-match="shallow-copy"/>
    <!--ebb: This is the magical line of code that creates an identity transformation in XSLT.
    This kind of XSLT creates a copy of the source document.
    -->
    
    <xsl:template match="emph">
        <hi rend="italics">
            
            <xsl:apply-templates/>
            
        </hi> 
        
    </xsl:template>
    
    <xsl:template match="head/l">
        
        <!--ebb: Do something in here to change <l>....</l> into <lb/> and don't LOSE any of the text contents. -->
        
    </xsl:template>
   
   
   <!--ebb: More template rules to make more changes! -->
    
    
    
    
</xsl:stylesheet>