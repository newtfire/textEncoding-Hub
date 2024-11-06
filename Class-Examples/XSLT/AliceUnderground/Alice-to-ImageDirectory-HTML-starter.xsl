<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0">
    <!-- What we want: For every chapter, list the headings. Write this processing first, 
                    starting in this template to set the outermost HTML list structure with <ul>, and apply-templates 
                    to select the <chapter> elements to process. 
                    
                    **In the new template rule after this one**, match on the chapter elements and replace them
                    with an html <li>....</li> element that holds the chapter headings. -->
   
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head> 
            <title>Image Directory for Alice's Adventures Underground</title>
            <!-- Link line for CSS would go here... -->
            </head>
            <body>
                <h1>An Image Directory for Alice's Adventures Underground</h1>
                

                <ul class="outerList"> <!-- Everything that processes just ONCE goes in this template rule -->
                    <xsl:apply-templates select="descendant::chapter"/>  
                </ul>
              
                <!-- The @select on xsl:apply-templates always takes a literal XPath from the context node. 
                    This is the ONLY template where it would be okay to write "//chapter", because
                    our template match IS the document node. But it's always safest to say descendant:: 
                    for all your apply-templates @select values when your context match can be deeper in the tree.
                    In those cases you don't ever want to start back at the document node! 
                    The context is your match attribute.
                    
                    EASY WAY TO REMEMBER? When you need to select elements on the descendant axis, 
                    just write descendant:: in @select like we're doing here. You can also just rely on the dot to start you
                    off with .//chapter. 

                -->
 
            </body>
   
        </html>
    </xsl:template>
    
    <xsl:template match="chapter">
        <li><!--Again, you need to apply-templates selectively here: 
            select JUST the node you want to process for the chapter headings. -->
            
            
            <ul>
               <!-- Inside the list items for the headings, use apply-templates selectively again here to start 
                   a sub-list of the image URLs/
            
            HTML OUTPUT STRUCTURE will look like this, 
            with a list nested inside each outer list item.

                        <li> Chapter Heading
                            <ul class="sublist">
                                <li>image URL</li>
                                <li>image URL</li>
                                <li>image URL</li>
                                ...more list items...
                                <li>image URL</li>
                            </ul>
                        </li> -->
            </ul>
        </li>
    </xsl:template>
    
    <!-- You will need a new template rule after this to match on the <image> elements and output 
    a <li> around their contents.-->
    
    
    
</xsl:stylesheet>