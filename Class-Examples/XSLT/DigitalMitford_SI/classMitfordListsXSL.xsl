<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
   <xsl:template match="/">
       <html>
           <head>
               <title>Organizations in Digital Mitford</title>
           </head>
           <body>
              <h1>Digital Mitford Place List</h1> 
              <ol>
                  <xsl:apply-templates select="descendant::listPlace"/>
              </ol> 
               
              <h1>Lists of Organizations</h1>
               <ol><!--Keep processing other lists if you like. --></ol>

           </body> 
       </html>
   </xsl:template> 
    
    
 <xsl:template match="listPlace">
        <li><xsl:apply-templates select="child::head"/>
             <ul>
                <xsl:apply-templates select="child::place"/> 
                 
             </ul>
        
        </li>
        
    </xsl:template>
    
    <xsl:template match="place">
       <!-- <li><xsl:apply-templates select="placeName => string-join(', ')"/></li>
     -->   
        <li><xsl:apply-templates select="placeName[1]"/></li>
    </xsl:template>
    
    
</xsl:stylesheet>