<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
 <!-- For this, let's make an HTML output file that lists poems and poem titles from the source Montage XML. -->
   
   <xsl:template match="/">
       <html>
           <head>
               <title>List of Poem Contents in Montage of a Dream Deferred</title>
               <!-- Link line for CSS would go here -->
           </head>
           <body>
               
               <h1>Poem Contents in Montage Collection</h1>            
               <ol class="outerList">
                  
                  <xsl:apply-templates select="descendant::poem"/>
                   
               </ol>
     
           </body>
   
       </html>
   </xsl:template>
    
    
    
    <xsl:template match="poem">
        
        <li><xsl:apply-templates select="child::poemTitle"/>
        <ul class="innerList">
            
            <xsl:apply-templates select=".//stanza"/>
            
            
        </ul>
   
        </li>
        
    </xsl:template>
    
    <xsl:template match="stanza">
        
        <li>Count of lines in this stanza:
            <xsl:value-of select="count(line)"/>
        </li>
    </xsl:template>
   
   
   
  
</xsl:stylesheet>