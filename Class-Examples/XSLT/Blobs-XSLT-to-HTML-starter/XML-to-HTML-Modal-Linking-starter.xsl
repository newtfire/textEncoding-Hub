<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head> 
            <title><xsl:apply-templates 
                select="descendant::title"/></title>
            <!-- Link line for CSS would go here... -->
            </head>
            <body>
              <h1><xsl:apply-templates select="descendant::title"/></h1>
                <!-- Here is a Table of Contents Overview -->
        <table>
            <tr>
                <th>Blob Heading</th>
                <th>Special Features</th>
                <th>Blob Preview in 30 characters</th>
            </tr>
            
            <xsl:apply-templates select="descendant::blob" mode="toc"/>
            
        </table>        
                
                <!-- BELOW is the Reading View processing -->
               
                <section class="reading">
                  <xsl:apply-templates select="descendant::blob"/>          
               </section> 
    
            </body>
   
        </html>
    </xsl:template>
  <xsl:template match="blob" mode="toc">
      <tr>
          <td><a href="#blob-{position() }"><xsl:apply-templates select="heading"/></a></td>
          <td><xsl:value-of select="descendant::special/@whatsIt ! normalize-space() => distinct-values() => string-join(', ') "/>
              <!--<xsl:value-of select="string-join(distinct-values(descendant::special/@whatsIt/normalize-space()), ', ')  "/> -->
          
          </td>
          <td>
              <xsl:value-of select="ab[1] ! 
                  substring(., 1, 30)"/>
          </td>
      </tr>
  </xsl:template>  
    
    
    
 <!-- BELOW HERE are the Reading View templates -->   
    <xsl:template match="blob"> 
        <h2 id="blob-{position() }"><xsl:apply-templates select="heading"/></h2>
        <section><xsl:apply-templates select="ab"/></section> 
    </xsl:template>
    
    <xsl:template match="ab">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    
    <xsl:template match="special">
        <span class="special"><xsl:apply-templates select="@whatsIt"/></span>
    </xsl:template>
    

</xsl:stylesheet>
