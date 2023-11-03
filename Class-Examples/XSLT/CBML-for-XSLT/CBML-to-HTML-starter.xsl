<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
   <xsl:template match="/">
       <html>
           <head>
               <title>....</title>
               <!-- Add a link line for CSS! -->
           </head>
           <body>
               <h1>....</h1> 
            
            <!-- What do you want to be pulling from the CBML documents to be displaying in HTML? -->
            
           </body>
       </html>
   </xsl:template> 
    
   <!-- ebb: Now, write new template rules to handle processing of XML elements where  you'll be getting lots of output:
       each single match generates a particular kind of output element in the HTML.
   -->
 
 
    
</xsl:stylesheet>