<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0">
   
    
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
                
              
                
               <table> <!-- Everything that processes just ONCE goes in this template rule -->
                    
                   <tr>
                       <th>Chapter Heading</th> 
                       <th>Image Info</th>
                   </tr>
                   
                   <xsl:apply-templates select="descendant::chapter"/>  
                   
                   
               </table>
              
                <!-- The @select on xsl:apply-templates always takes a literal XPath from the context node. 
                    This is the ONLY template where it would be okay to write "//chapter", because
                    our template match IS the document node. But it's always safest to say descendant:: 
                    for all your apply-templates @select values when your context match can be deeper in the tree.
                    In those cases you don't ever want to start back at the document node! 
                    The context is your match attribute.
                    
                    EASY WAY TO REMEMBER? When you need to go down the descendant axis, 
                    just write descendant:: in @select like we're doing here.

                -->
 
            </body>
   
        </html>
    </xsl:template>
    
  <xsl:template match="chapter">
         
      <tr>
      
           <td><xsl:apply-templates select="heading"/></td>
          
          <td> 
              <ul><xsl:apply-templates select=".//image"/></ul>
          
          </td>
        
      </tr>    
        
        
    </xsl:template>
    
    <xsl:template match="image">
        <li><xsl:apply-templates select="@source"/></li>
    </xsl:template>
   
    
 
    
    
</xsl:stylesheet>