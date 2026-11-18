<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <!-- COLLECTION VARIABLE: this one is excluding the site index file that's in the same directory. 
        You don't need the @as attribute, but it's best practice to use it, to indicate what kind of content
        this variable is storing: This one indicates it's storing one or more document-nodes for a collection of XML documents.
    -->
    <xsl:variable name="cbml-collection" as="document-node()+" 
        select="collection('xml/?select=*.xml')[base-uri() ! not(contains(., 'cbml-si'))]"/>
    
    <!-- ebb: Make sure there are no extra spaces inside the collection(' ') variable.   -->
    
   <xsl:variable name="site-index" as="document-node()" select="doc('xml/cbml-si.xml')"/>
 
   <!-- ____WHAT THIS XSLT STYLESHEET DOES________ -->
    <!--ebb: This is designed to process a collection of XML files and:
        * Make separate reading view HTML files, one for each XML document
        * Output a table of contents with links to each output HTML file
        * Ultimately, also reach into a separate "site index" XML file that stores distinct identifiers
        
        As of Monday 2026-11-16, it is outputting a linked table of contents, and separate HTML files.
        This demonstrates the use of <xsl:result-document> to create a new HTML file as output
        as you are processing each of your XML input files.-->
    <!-- We'll proceed on Wednesday 11-18 to process references to the special cbml-si. xml Site Index file. -->
    <!-- ____________________________________ -->
    
   
   <xsl:template match="/">
       
       <!-- **********Table of Contents as Distinct HTML Page.*******************
          ebb: We're creating ONE separate page here for a table of contents on the website
           that links out to the reading view HTML files.
           We should configure a special <xsl:result document> output here to store this one special
       linked table of contents file.  
       NOTES: <xsl:result document> lets you indicate your file storage destination filepath!
   
       * Define that filepath in relation to where you save your XSLT file: XSLT will look there to store the output.
       Any and all HTML output is going into our docs/ directory. 
       Here we save exactly one file named toc.html into docs/ .
       * When you use <xsl:result-document> you do not need or want to set an Output file in the oXygen XSLT window.
       
       ****************************************************************************
       -->
       <xsl:result-document method="xhtml" html-version="5" 
           omit-xml-declaration="yes" include-content-type="no"
           indent="yes" href="docs/toc.html">
       <html>
           <head>
               <title>Table of Contents for the Team Fortress Reading View</title>
               <link rel="stylesheet" type="text/css" href="style.css"/> 
           </head>
           <body>
               <h1>Table of Contents</h1>
                   
                 <ol>     
                    <xsl:apply-templates select="$cbml-collection//titleStmt/title" mode="tocPage">
                        <xsl:sort select="base-uri()! tokenize(.,'/')[last()]"/>
                    </xsl:apply-templates>
                     <!-- Look for our matching modal template rule for titleStmt/title
                         We'll process these to construct direct links to each file in our
                         reading view. 
                     -->  
                 </ol>
               
           </body>
       </html>
    </xsl:result-document>
            <!-- _____SPECIAL PROCESSING TO OUTPUT A NEW HTML FILE FOR EACH XML FILE (EXCEPT THE SITE INDEX) __________-->
            <!-- ebb: Here, we apply xsl:for-each in order to process the collection of files (except the site index)
            to output a new HTML "result document" for each XML document node. 
            
            When we call "current()" in XSLT, we return info about the specific node that is 
            NOW being processed. Each individual node will have its own filename, which we pick up with
            base-uri(). 
            -->
            <!-- ____________________________________________________________________ -->
            <xsl:for-each select="$cbml-collection">
                <!--<xsl:sort select="base-uri()! tokenize(.,'/')[last()]"/>-->
                <xsl:variable name="filename" select="current() ! base-uri() ! tokenize(., '/')[last()] ! 
                    substring-before(., '.xml')"/>
                <xsl:result-document method="xhtml" html-version="5" 
                    omit-xml-declaration="yes" include-content-type="no"
                    indent="yes" href="docs/{$filename}.html">
                    <html>
                        <head><title><xsl:apply-templates 
                                    select="descendant::titleStmt/title" mode="titleLine"/></title>
                            <link rel="stylesheet" type="text/css" href="style.css"/> 
                        </head>
                        <body>
                            
                            <div id="reading-view">  
                                <xsl:apply-templates select="descendant::titleStmt/title"/>
                                <xsl:apply-templates select="descendant::div"/>
                            </div>
                            
                        </body>
                        
                    </html>
                    

               </xsl:result-document>
            </xsl:for-each>

   </xsl:template> 
    
    <!-- tocPage mode -->
    <xsl:template match="titleStmt/title" mode="tocPage">
        
        <li><a href="{current() ! base-uri(.) ! tokenize(., '/')[last()] ! 
                substring-before(., '.xml')}.html">
                <xsl:apply-templates select="current()"/></a></li>
        
    </xsl:template>
    
    <!-- Title line in HTML head -->
    
    <xsl:template match="titleStmt/title" mode="titleLine">
       <xsl:apply-templates/>
    </xsl:template>
    
    
    <!-- Reading view default -->
    
    
    <xsl:template match="titleStmt/title">
        <h1><xsl:apply-templates/></h1>
        
    </xsl:template>
    
    <xsl:template match="div[@type='page']">
        <section class="{@type}" id="page-{@n}">
            <xsl:apply-templates/>

        </section>
    </xsl:template>
    
    <xsl:template match="cbml:panel">
        <!-- ebb: Is this coded consistently in the source XML files? -->
        <div class="panel" id="page-{ancestor::div[@type='page']/@n}-panel-{@n}">
         <!-- ebb: I noticed that not all the panels have characters, so it's a good
         idea to set an <xsl:if> to process ONLY when they do. <xsl:if> is a 
         simple version of <xsl:choose>. -->
           <xsl:if test="@characters"><span class="tinyInfo">
              <xsl:text>Character in this panel: </xsl:text>
              <xsl:value-of select="@characters"/>
            </span>
           </xsl:if> 
         <xsl:apply-templates/>            
            
        </div>
    
    </xsl:template>
    
    <xsl:template match="cbml:caption">
        <p class="cbml-caption">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="cbml:balloon">
    <!-- ebb: Reach into the $site-index document to look up info about the speaker in
    this balloon! 
    Here we can construct tooltips and apply some CSS to them. 
    @title attribute is the leanest/simplest way, but for more styling control,
    here's w3schools tutorial:
    https://www.w3schools.com/css/css_tooltip.asp
    
    In Team Fortress code, the @who attribute matches up with the <name> element
    in the cmbl-si.xml, so that's what we're matching. You will likely need to change this
    for other projects.
    -->
        <xsl:variable name="si-match" as="element()?"
            select="$site-index//*[name ! normalize-space() ! lower-case(.) = current()/@who ! normalize-space() ! lower-case(.)]"/>
        <!-- ebb: When I created this variable and used the @as to say it's storing an element(), 
            I needed to give a zero-or-one repetition indicator: "element()?" in case there is no matching entry in the si yet! 
        The variable works just fine without this @as attribute. 
        Still, it's always best practice to "type" your variables (incidate what kind of content is expected to be in here,
        even if it's a pain sometimes. :-)
        -->
        <div class="balloon {@type}">
            <!-- ebb: What to do if a balloon isn't for speech? This is a good place
            to try <xsl:choose>. 
            -->
          <xsl:choose> 
              <xsl:when test="@type='speech'">
              <span class="who" 
                title="{$si-match/desc}">
                <xsl:value-of select="@who"/><xsl:text>: </xsl:text>
            </span>
                  <xsl:apply-templates/>
              </xsl:when>
             <!-- other types of balloons could get other xsl:when tests for processing -->
              <xsl:otherwise>
                  <span class="tinyInfo"><xsl:value-of select="@type"/></span>
                  
                  <xsl:apply-templates/>
                  
              </xsl:otherwise>
          </xsl:choose>  
        </div>
    </xsl:template>
    
    <xsl:template match="note">
        <p class="{@type}">
            <xsl:apply-templates/>
        </p>  
    </xsl:template>
    
    <xsl:template match="sound">
        <span class="{name()}" style="color:red">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    
    <!-- ebb: These are templates from another XSLT for CBML: not sure if they are
    needed / relevant to this project. Be careful where you set <p> elements in 
    HTML, though! They must not nest in valid HTML output!
    -->
    <xsl:template match="p | figDesc[not(ancestor::p)]">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="figure[not(parent::p)]">
        <figure class="{@type}">
            <xsl:apply-templates/>
            
        </figure>
  
    </xsl:template>

</xsl:stylesheet>