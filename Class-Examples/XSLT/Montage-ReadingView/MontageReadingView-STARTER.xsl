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
    
<!--    <xsl:template match="title">
        <h1><xsl:apply-templates/></h1>
    </xsl:template>-->
    
    <xsl:template match="poem">
        <xsl:if test="poemTitle/text()">
            <h3><xsl:apply-templates select="poemTitle ! normalize-space()"/></h3>
            
            <!--ebb: Below is a complicated version of outputting the poem titles in an <h3> with an @id attribute, using an AVT to make a distinct id without spaces or special characters, made from the poem titles and their XPath position(): Try uncommenting it to see how it works:-->
       <!-- 
           <h3 id="{poemTitle ! translate(., ' ', ''){position()}"><xsl:apply-templates select="poemTitle ! normalize-space()"/></h3>
        -->
        </xsl:if>
        
        <!--ebb: This portion just applies templates now to the body of the poem. We're wrapping an HTML <section> element around the whole poem, and then applying templates to continue processing children and descendants from this point. The next template rule to process an element will be the one matching on stanza. -->
        <section class="poem"><xsl:apply-templates select="body"/></section>
    </xsl:template>
    
    <xsl:template match="stanza">
        <section class="stanza">
            <xsl:apply-templates/>
        </section>
    </xsl:template>
    
    <xsl:template match="line">
        <span class="lineNum"><xsl:apply-templates select="@n"/></span>
        <div class="line"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="format[@wordtype='italics']">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    <xsl:template match="format[@margin='ind1']">
        <span class="ind1"><xsl:apply-templates/></span>
        
    </xsl:template>
   
        
    
</xsl:stylesheet>
