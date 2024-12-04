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
        <!--We needed to create this variable in order to store the template match element (<script>), 
            so we can work with it inside the <xsl:for-each> that we started. -->
        
        <xsl:for-each select="descendant::*/@who ! normalize-space() => distinct-values() => sort()">
          <!-- In this case for a cast list, we are using xsl:for-each
          to reach each member of a calculated list of distinct values. 
          We can't write template rules to match on these because the distinct-values are calculated. They are not 
          on the source XML tree. 
          
          Notes about the BASIC LINK STRUCTURE. This holds for ANYTIME you need to construct internal links:
                
                1. First of all, plant the id attributes down in the Reading View templates (not here!): 
                <div id="{XPath-that-constructs-an-id}">....</div>
               
                2. Then, up where you process the Table of Contents, make the links to reach those ids: 
                <a href="#{XPath-that-constructs-the-id-you-made-in-the-Reading View}">....</a>
                Remember, you need the # in the href attribute to indicate that you're pointing to an id attribute elsewhere in the HTML file.
                    Maybe this is reaching only a selection of the ids you "planted" in the reading view (like in this cast list example). Or maybe it
                is pointing to every single chapter or every division to let you jump down to that location. 
                Either way, you want to make sure your links simply work to reach *what you intend them to reach*.
          -->
            
            <tr>
                <td> <a href="#d-{current()}-{($nodeContext//d[@who ! normalize-space() = current()])[1]/preceding::d => count() + 1}"> 
                    <xsl:value-of select="current()"/></a>
                    
                <!-- We want to link to the FIRST MOMENT EACH CHARACTER SPEAKS in the script, so we'll work with the <d> elements indicating dialogue.
                
                From my Reading View template, I constructed a link id (as a target for these links) to look like
                this for dialogue: id="d-{@who}-{count(preceding::d) + 1}"
                
                In my video, I went to construct the <a href="#{id}"> links from the TOC, 
                and I had to work out a way to reach the *very first* of these dialogue elements for each character. 
                I tried one way that did NOT work, and then did a bit of "rubber ducking" (thinking out loud) to figure out
                how to to access the *very first* <d> element that matches the current character and retrieve the count() of its preceding::d elements.
                
                We had to correct an error with processing, because our xsl:for-each was calculating distinct-values **pulled off the source XML tree**. 
                Our xsl:for-each actually creates a new processing context, so the XSLT running inside it literally *forgets* the xsl:template match node (which 
                was the <script> element. So we had to create the local $nodeContext variable (above the xsl:for-each) to store that <script> element
                to work with it inside <xsl:for-each>.  
                We called on that $nodeContext variable to **return to the source XML tree**: 
                Just unpacking the first part of this: $nodeContext//d means:
                go back to the <script> element and look down from there to find all the descendant::d elements. 
       
                NOTE that because we were working with distinct-values() to build the cast list, and we were using xsl:for-each, 
                our approach to link construction in this project example is more complicated that what you'll need to do on the XPath/XSLT test. 
                (The XPath/XSLT test does NOT require you to work with xsl:for-each to create the table of contents.)
                But you may want to do something like this on your projects to create tables of characters, or locations, return information about where they're referenced.
                
                Working this out step by step was definitely a thinking process! Rubber-ducking / talking through it / writing it out in words 
                will help you/us to figure out how to do it in your project. 
                -->
                </td>
                <td>
                    <xsl:value-of select="$nodeContext//d[@who = current()] => count()"/>
                    <!-- ebb: This was SO much easier to do after we worked out how to make good links. We start with that helpful $nodeContext
                    and go down and find all the d elements that match the current distinct speaker, and return XPath's count() of them. -->
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
    
    <!-- ebb: In the templates that match on scene, d, and char, we constructed id attributes based on count of preceding scenes. This is very
    similar to our very first XSLT identity-transformation assignment where you learned how to write ATVs (attribute value templates). 
    The difference is that in that early assignment, we constructed attributes to plant distinct xml:ids (for use in XML) on the source
    document as a patch to it. You could choose to do this on your project code: Do an identity transformation and plant identifiers 
    in your source XML that you can work with later. If you're reading from your own xml:ids, your code might look like this:
    
    <xsl:template match="scene">
      <div class="scene" id="{@xml:id}">
            <xsl:apply-templates/>
      </div>
    </xsl:template>
    
    But if you haven't done that, you can construct HTML id attributes here using the same logic: count the preceding whatevers, construct something 
    that's a combination of letters and numbers. Remember that in our web world, an id is supposed to include letters and numbers. 
    Hyphens and underscores are okay.
    -->
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