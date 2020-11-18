<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
  <xsl:template match="/">
      <html>
          <head>
              <title>Montage of a Dream Deferred</title>
              <link rel="stylesheet" type="text/css" href="montageStyle.css"/>
              <!--ebb: Change the above to your CSS file! -->
          </head>
         <body>
             <xsl:apply-templates select="descendant::poem[following-sibling::title]"/>
             
             <h1><xsl:apply-templates select="descendant::title"/></h1>
             <h2>by Langston Hughes</h2>
             
             <xsl:apply-templates select="descendant::poem[preceding-sibling::title]"/> 
 
         </body>
      </html>      
  </xsl:template>
    
    <xsl:template match="poem">
        <xsl:if test="poemTitle">
            <h3><xsl:apply-templates select="poemTitle"/></h3>
        </xsl:if>
        <xsl:apply-templates select="descendant::stanza"/>
       
    </xsl:template>
    
    <xsl:template match="stanza">
        <section class="stanza"><xsl:apply-templates/></section>
    </xsl:template>
    
    <xsl:template match="line">  
    <xsl:choose>    
        <xsl:when test="child::format[@margin='ind1']">
           <div class="line"><span class="LineNum"><xsl:value-of select="@n"/></span>
           <span class="{format/@margin}"><xsl:apply-templates/></span></div>
           </xsl:when>
    <xsl:otherwise>
        <div class="line"><span class="LineNum"><xsl:value-of select="@n"/></span>
            <xsl:apply-templates/></div>
    </xsl:otherwise>
    </xsl:choose>
    </xsl:template>
    
    <xsl:template match="format[@wordType='italics']">
     <em><xsl:apply-templates/></em>      
    </xsl:template>
   
        
    
</xsl:stylesheet>
