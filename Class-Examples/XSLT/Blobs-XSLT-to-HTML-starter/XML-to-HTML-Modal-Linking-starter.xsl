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
            <title>List from <xsl:apply-templates select="descendant::title"/></title>
            <!-- Link line for CSS would go here... -->
            </head>
            <body>
              <h1>Hello DIGIT 110!</h1>
                
               
                
               <section class="reading">
                   
                  <xsl:apply-templates select="descendant::blob"/>
                   
               </section> 
    
            </body>
   
        </html>
    </xsl:template>
    
    
    <xsl:template match="blob"> 
        <h1><xsl:apply-templates select="heading"/></h1>
        <p><xsl:apply-templates/></p>
        
    </xsl:template>
    
    
    <xsl:template match="special">
        <span class="special"><xsl:apply-templates select="@whatsIt"/></span>
    </xsl:template>
    

</xsl:stylesheet>
