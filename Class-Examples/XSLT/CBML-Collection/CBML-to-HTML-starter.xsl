<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:variable name="cbml-collection" as="document-node()+" select="collection('cbml/?select=*.xml')"/>
    <!-- 2023-11-08 ebb: MAKE SURE THERE ARE NO EXTRA SPACES in the collection() variable!   -->
    
   <xsl:template match="/">
       <html>
           <head>
               <title>CBML Transformation!</title>
               <link rel="stylesheet" type="text/css" href="style.css"/> 
           </head>
           <body>
               <!-- What do you want to be pulling from the CBML documents to be displaying in HTML? -->
               <h1>Titles and Authors of Comic Books in the Collection</h1> 
            
            <ul>
               <xsl:apply-templates select="$cbml-collection//titleStmt"/>
            </ul>
            
           </body>
       </html>
   </xsl:template> 
    
   <!-- ebb: Now, write new template rules to handle processing of XML elements where  you'll be getting lots of output:
       each single match generates a particular kind of output element in the HTML.
   -->
  <xsl:template match="titleStmt">
       
       <li><em><xsl:value-of select="title"/></em> 
           <xsl:text>by</xsl:text> 
           <xsl:apply-templates select="author"/>
           
       </li>
       
   </xsl:template>
    
 

    
</xsl:stylesheet>