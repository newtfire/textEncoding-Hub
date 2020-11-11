<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:template match="/">
        <html>
            <head>
                <!--ebb: From our HTML tutorial: good setup for HTML pages on newtfire. -->
                <title>
                    <xsl:apply-templates select="descendant::titleStmt//title"/> </title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="explain.css"/>  
            </head>
            <body>
                <ol>
                <xsl:apply-templates select="descendant::person"/>

                </ol>
          <!--  <xsl:apply-templates select="descendant::profileDesc"/>-->
            
            </body>
        </html>
    </xsl:template>
    
    
  <xsl:template match="person">
     <li><xsl:value-of select="descendant::persName[not(child::persName)][1]"/>
         <!--ebb: Let's say we want to make a list of every speech this character delivers in the anime. Start by create a list *inside* the list element, and then construct what you want to go inside.-->
         <ul>
             <li><!--ebb: We're going to do a little XPath here and output a count of the number of speeches this character gets in the play.  -->
                 <xsl:value-of select="count(//text//sp[substring-after(@who, '#') = current()/@xml:id])"/></li>
          
          <!--Here we'll reach into the tree and look for multiple nodes associated with our character: Notice we do NOT wrap this in an <li> element. Try positioning one to see why not: -->
             <xsl:apply-templates select="//text//sp[substring-after(@who, '#') = current()/@xml:id]"/>
         </ul>
     </li> 
      
  </xsl:template>

<!--ebb: This sp template process each speech and outputs its text, into our nested sub-list. -->
    <xsl:template match="sp">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    
</xsl:stylesheet>
