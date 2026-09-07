<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <!--ebb: Here's the extra special
    line we need to do an Identity Transformation. -->
    
   <xsl:mode on-no-match="shallow-copy"/>
    
  
    <!-- ebb: Now we write template rules to match on patterns in the source document, and output new patterns.  -->
  
  <xsl:template match="sonnet">
   <poem type="sonnet" romNum="{@number}" num="{preceding-sibling::sonnet => count() + 1 }"> <xsl:apply-templates/>
   </poem> 
  </xsl:template>
  
  
  <xsl:template match="line">
    <!-- How will I output an <lb/> at the
    start of each line?-->
   <lb num="{count(preceding-sibling::line) + 1}"/> <xsl:apply-templates/>
    <!-- attribute value template -->
  </xsl:template>
    
    
</xsl:stylesheet>