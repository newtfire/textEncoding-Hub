<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <!--ebb: Here's the extra special
    line we need to do an Identity Transformation. -->
    
       <xsl:mode on-no-match="shallow-copy"/>
    
   <xsl:template match="sonnets">
       <xml>
           <dateProcessed>
               <xsl:value-of select="current-dateTime()"/>
           </dateProcessed>
           <xsl:apply-templates/>
           
       </xml>

   </xsl:template>
  
  
    <!-- ebb: Now we write template rules to match on patterns in the source document, and output new patterns.  -->
   
   <xsl:template match="sonnet">
       <poem type="sonnet" roman="{@number}"
           number="{preceding-sibling::sonnet => count() + 1}">
           <xsl:apply-templates/>
       </poem>
   </xsl:template>
   
   
   <xsl:template match="line">
       <ln number="{count(following-sibling::line) + 1  }"><xsl:apply-templates/></ln>
      <!-- ebb: We just messed with this in class to show you
      what following-sibling:: and following:: processing does.
      Try this with preceding-sibling:: and preceding:: 
      -->
   </xsl:template>
 
 
 

 
    
</xsl:stylesheet>