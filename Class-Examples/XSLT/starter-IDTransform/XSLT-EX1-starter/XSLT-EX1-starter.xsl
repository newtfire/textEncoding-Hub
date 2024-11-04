<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!--Tasks: Write XSLT template rules to do the following:
        
        
     1. Change the <poemTitle> elements to <title>.
     
     2. We don't need the <body> elements, so let's remove them but preserve their contents
     
     The next two questions ask you to write Attribute Value templates to pull in or calculate a value from the source XML.
    READ ABOUT/LOOK AT EXAMPLES OF ATTRIBUTE VALUE TEMPLATES HERE:
     http://dh.obdurodon.org/avt.xhtml
     
    3. Change the <line> elements into self-closing <lb/> elements to sit at the beginning of each line,
    but keep the @n attribute on them to preserve the line number information.
    
    4. Each poem should have a distinct identifier, usually called an @xml:id attribute.
    Write an attribute value template to add an xml:id attribute to each poem that includes "p-" followed by its number in the sequence of poem elements. 
    (You can calculate this with XPath by counting the preceding poem elements in the document and adding 1.)
    
    -->
   
  
 
   
</xsl:stylesheet>