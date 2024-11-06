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
            <title><xsl:apply-templates select="descendant::title"/></title>
            <!-- Link line for CSS would go here... -->
            </head>
            <body>
              <h1>Hello DIGIT 110!</h1>
                
               <ol>
                   
                  <xsl:apply-templates select="descendant::blob"/>
                   
               </ol> 
    
            </body>
   
        </html>
    </xsl:template>
    
    
    <xsl:template match="blob"> 
        <li><xsl:apply-templates select="heading"/>
             <ul>
                 
             <xsl:apply-templates select="descendant::special"/>
                 
             </ul>
        </li>
    </xsl:template>
    
    
    <xsl:template match="special">
        <li><xsl:apply-templates select="@whatsIt"/></li>
    </xsl:template>
    
    
    <!--  BATTLE PLAN: 
    <ol>
        <li>BLOB HEADING
            <ul>
                <li>special whatsit</li>          
            </ul>

        </li>       
    </ol>  
    --> 
</xsl:stylesheet>
