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
             
             <!--ebb: Table of contents + information here. -->
            <table> 
             <tr><!--The top row of an HTML table contains <th> cells for table column headings.
             Set the table up with the headings we want.-->
                 
                 <th>Chapter Number</th>
                 <th>Locations mentioned</th>
                 <th>Tech mentioned</th>
             </tr>
                <xsl:apply-templates select="descendant::chapter" mode="toc"/>
                
            </table>
             
             <!--ebb: Reading view of the chapters here. -->
             <xsl:apply-templates select="descendant::chapter"/>
        </body>
     </html>
 </xsl:template>
    <xsl:template match="chapter" mode="toc">
        <tr>
            <td></td>
            <td></td>
            <td></td>   
         </tr>
    </xsl:template>
    
    <xsl:template match="chapter">
        <h2 id="C{count(preceding-sibling::chapter) + 1}"><xsl:apply-templates select="heading"/></h2>
        <xsl:apply-templates select="p"/>
    </xsl:template>
    
   
    
</xsl:stylesheet>