<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <!-- 2024-11-11 ebb: We're using the xd:documentation elements on this XSLT. Feel free to
    try them on your own stylesheets! Basically the xd:schema requires that we write some 
    documentation about the whole stylesheet and then on each template rule. 
    NOTE: We now have to include the xd in the list of exclude-result-prefixes. 
    (Notice what happens to the output root HTML element if we remove it from that list.) -->
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 11, 2024</xd:p>
            <xd:p><xd:b>Author:</xd:b> eeb4</xd:p>
            <xd:p>XSLT transformation to HTML from Sherlock Holmes Radio Play</xd:p>
            <xd:p>Source: Jacqueline Chan (wdjacca) project repo: 
                <xd:a href=" https://github.com/wdjacca/SherlockHolmesRadioScripts "></xd:a> </xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    <xd:doc>
        <xd:desc>Here is the template matching on the document node that 
            changes the XML to an HML document.</xd:desc>
    </xd:doc>
    <xsl:template match="/">
        <html>
            <head> 
            <title>
<<<<<<< HEAD
                    <xsl:apply-templates select="descendant::metadata/series"/>
                        <xsl:text>!</xsl:text>
                    <xsl:apply-templates select="descendant::metadata/show"/>
            </title>
                <!--  <link rel="stylesheet" type="text/css" href="radioplay.css" /> -->
            </head>
            <body>
                <h1><xsl:apply-templates select="descendant::metadata/show"/></h1>
                <h2><xsl:apply-templates select="descendant::metadata/series"/></h2>
                <h3><xsl:apply-templates select="descendant::metadata/date"/></h3>
                
                <section class="cast">
                        <xsl:apply-templates select="descendant::metadata/castList"/>
                    
                </section>
                
                <section class="script">
                    
                        <xsl:apply-templates select="descendant::script"></xsl:apply-templates>
                    
                </section>
                
            <xsl:apply-templates/>
            
            </body>
        </html>
    </xsl:template>
    <xd:doc>
        <xd:desc>This template processes the cast list and outputs an unordered list in HTML</xd:desc>
    </xd:doc>
=======
                <xsl:apply-templates select="descendant::metadata/series"/> 
                <xsl:text>! </xsl:text>
                <xsl:apply-templates select="descendant::metadata/show"/> 
            </title>
                <link rel="stylesheet" type="text/css" href="radioplay.css" /> 
            </head>
            <body>
                <h1><xsl:apply-templates select="descendant::metadata/show"/> </h1> 
                <h2><xsl:apply-templates select="descendant::metadata/series"/> </h2>  
                <h3><xsl:apply-templates select="descendant::metadata/date"/></h3>
         
         <section class="cast">
             <xsl:apply-templates select="descendant::metadata/castList"/>
         </section>
                
         <section class="script">
             
             
             <xsl:apply-templates select="descendant::script"/>
 
         </section>
 
            </body>
        </html>
    </xsl:template>
   <xd:doc>
       <xd:desc>This template processes the cast list and outputs an unordered list in HTML</xd:desc>
   </xd:doc> 
    <xsl:template match="castList">
        <h3>Cast List</h3>
        <ul>
             <xsl:apply-templates select="cast"/>   
        </ul>  
    </xsl:template>
    
    <xd:doc>
        <xd:desc>This processes the cast list items.</xd:desc>
    </xd:doc> 
    <xsl:template match="cast">
 <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xd:doc>
        <xd:desc>I want to process just the speech parts with this next template.</xd:desc>
    </xd:doc> 
    <xsl:template match="ln[speaker]">
       <div class="speech">
      
           <xsl:apply-templates/>       </div>

    </xsl:template>
    
    <xsl:template match="speaker">
        <span class="speaker"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="mention">
        <span class="mention"><xsl:apply-templates/></span>
    </xsl:template>
    
    
    
   <xd:doc>
        <xd:desc>I want to process all the other ln elements with this next template.</xd:desc>
    </xd:doc> 
    <xsl:template match="ln[not(speaker)]">
       <div class="nonspeech"> 
           <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    
    
    
    
    
>>>>>>> refs/remotes/origin/master
    
    <xsl:template match="castList">
            <h3>Cast List</h3>
            <ul>
                
                <xd:doc>
                    <xd:desc></xd:desc>
                </xd:doc>
               <xsl:template match="cast"><li><xsl:apply-templates/></li>
               </xsl:template> 
                
                <xd:doc>
                    <xd:desc>I want to process just the speech parts with this next template.</xd:desc>
                </xd:doc>
                
                <xsl:template match="ln[speaker]">
                    <div class="speech">
                        
                        <xsl:apply-templates/>
                    </div>
                </xsl:template>
            </ul>
        
      </xsl:template>
    
                <xd:doc>
                    <xd:desc>I want to process all other ln elements with this next template.</xd:desc>
                </xd:doc>
                <xsl:template match="ln[not(speaker)]">
                    
                </xsl:template>
   
</xsl:stylesheet>
