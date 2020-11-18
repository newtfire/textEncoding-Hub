<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
 <xsl:template match="/">
     <html>
         <head>
             <title>Dracula</title>
             <link rel="stylesheet" type="text/css" href="style.css"/>
         </head>
         <body>
           <h1><xsl:apply-templates select="descendant::title"/></h1>
             
             <!--ebb: Table of contents here. -->
           <section id="contents"> <table> 
             <tr>
                 <th>Chapter Number</th>
                 <th>Locations mentioned</th>
                 <th>Tech mentioned</th>
             </tr>
                <xsl:apply-templates select="descendant::chapter" mode="toc"/>
       <!--ebb: This xsl:apply-templates line sets up my "toc" mode for the table of contents, 
      so that in the top part of the document we’ll output a selection of the body elements 
      specially formatted for my Table of Contents, and so that in another section of my document below, which I’ve put inside an HTML <section> element, we can also output the full text of the poems with their titles again.--> 
                
            </table></section>
             
             <!--ebb: Reading view of the chapters here. -->
            <section id="readingView">
                <xsl:apply-templates select="descendant::chapter"/>
            </section>
        </body>
     </html>
 </xsl:template>
    <xsl:template match="chapter" mode="toc">
        <tr>
            <td><xsl:apply-templates select="heading"/></td>
            <td><xsl:apply-templates select="descendant::location => distinct-values() => string-join(', ') "/></td>
            <td><xsl:apply-templates select="descendant::tech => distinct-values() => string-join(', ')"/></td>
         </tr>
    </xsl:template>
    
    <xsl:template match="chapter">
        <h2 id="C{count(preceding-sibling::chapter) + 1}"><xsl:apply-templates select="heading"/></h2>
        <xsl:apply-templates select="p"/>
    </xsl:template>
    
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
   
   <xsl:template match="date">
       <span class="date"><xsl:apply-templates/></span>
   </xsl:template>
    
    <xsl:template match="time">
        <span class="time"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="location">
        <span class="location"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="tech">
        <span class="tech"><xsl:apply-templates/></span>
    </xsl:template>
    

</xsl:stylesheet>