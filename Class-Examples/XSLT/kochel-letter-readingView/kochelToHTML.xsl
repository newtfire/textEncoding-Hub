<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <!--ebb: Our XML input has no namespace, so we don't need the xpath-default-namespace attribute.
But we are outputting in the XHTML namespace, so we need that one.     
    -->
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
   <xsl:template match="/">
       <html>
           <head>
               <title></title>
               <link rel="stylesheet" type="text/css" href="style.css"/>
               
           </head>
           <body>
             <xsl:apply-templates select=".//body"/>
           </body>
       </html>
       
   </xsl:template>
    
 

</xsl:stylesheet>