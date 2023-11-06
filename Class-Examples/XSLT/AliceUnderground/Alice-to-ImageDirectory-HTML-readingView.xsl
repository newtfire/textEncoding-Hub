<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0">
   
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head> 
            <title>Image Directory for Alice's Adventures Underground</title>
            <!-- Link line for CSS would go here... -->
                <link rel="stylesheet" type="text/css" href="style.css"/> 
            </head>
            <body>
                <h1>An Image Directory for Alice's Adventures Underground</h1>
     
                   
                   <xsl:apply-templates select="descendant::chapter"/>  
       
 
            </body>
   
        </html>
    </xsl:template>
    
    <xsl:template match="heading">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
 
 <xsl:template match="p">
     <p><xsl:apply-templates/></p>
 </xsl:template>
    
    <xsl:template match="char">
        <span class="char"><xsl:apply-templates/></span>
    </xsl:template>
 
    
</xsl:stylesheet>