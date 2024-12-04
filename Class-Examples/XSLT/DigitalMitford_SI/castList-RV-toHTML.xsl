<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs math"
    version="3.0">
    
<!-- XSLT comments are great! They are the same as XML comments. -->   

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <!-- My intention is to output a cast list that links to the first
    time a character speaks in this script. I'll be using modal XSLT to process
    some nodes in two different ways. 
    -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Taxi Driver Output</title>
                <link rel="stylesheet" type="text/css" href="taxidriver.css" /> 
            </head>
            <body>
                <h1>Hello world!</h1>
             
             <section class="castList">
                <table>
                    <tr>
                        <th>Cast of Characters Linked to their First Dialogue</th>
                        <th>Count of their total speeches</th> 
                    </tr>  
                    
                    <xsl:apply-templates select="descendant::script" mode="toc"/>
                </table>
             </section>
                
                <section class="readingView">
                    
                    <xsl:apply-templates select="descendant::script"/>
                </section>
                
            </body>
        </html>  
    </xsl:template>
    
    <!-- Table of Contents Mode -->
    
    <xsl:template match="script" mode="toc">
        <xsl:variable name="nodeContext" as="element()" select="current()"/>
        
        <xsl:for-each select="descendant::*/@who ! normalize-space() => distinct-values() => sort()">
          <!-- In this case for a cast list, we are using xsl:for-each
          to reach each member of a calculated list of distinct values. 
          We can't write template rules to match on these because they are not 
          on the source XML tree. 
          -->
            
            <tr>
                <td> <a href="#d-{current()}-{($nodeContext//d[@who ! normalize-space() = current()])[1]/preceding::d => count() + 1}"> <xsl:value-of select="current()"/></a>
                    
                <!-- Link to the first moment each character SPEAKS in the script. 
                
                From my Reading View template, I constructed a link id (as a target for these links) to look like
                this for dialogue: d-{@who}-{count(preceding::d) + 1 
                -->
                </td>
                <td>
                    <xsl:value-of select="$nodeContext//d[@who = current()] => count()"/>
                </td>
                
            </tr>
   
        </xsl:for-each>
        
        
    </xsl:template>
    
    <!-- Reading View Templates  -->
    
    <xsl:template match="script">
        <h1><xsl:apply-templates select="preceding::title"/></h1>
        
        <p class="openQuote">
            <xsl:apply-templates select="openQuote"/>
        </p>
        
        <xsl:apply-templates/> 
    </xsl:template>
    
    <xsl:template match="intro">
        <div class="scene" id="scene-intro">
            <xsl:apply-templates/>
            
        </div>
        
    </xsl:template>
    
    
    <xsl:template match="scene">
        <div class="scene" id="scene-{count(preceding::scene) + 1}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="narr">
   <section class="narr">
       <xsl:apply-templates/>
   </section>
</xsl:template>
    
    <xsl:template match="d">
        <div class="dialogue" id="d-{@who}-{count(preceding::d) + 1}">
            <xsl:apply-templates/>  
        </div>
    </xsl:template>
    
    <xsl:template match="char">
        <span class="char" id="char-{@who}-{count(preceding::char) + 1}"> </span>
    </xsl:template>
    
    <xsl:template match="shot">
        
        <span class="shot">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>