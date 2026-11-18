<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <!-- COLLECTION VARIABLE: this one is excluding the site index file that's in the same directory. -->
    
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
                    <xsl:apply-templates select="$cbml-collection//titleStmt/title" mode="tocPage"/>
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
                <xsl:variable name="filename" select="current() ! base-uri() ! tokenize(., '/')[last()] ! 
                    substring-before(., '.xml')"/>
                <xsl:result-document method="xhtml" html-version="5" 
                    omit-xml-declaration="yes" include-content-type="no"
                    indent="yes" href="docs/{$filename}.html">
                    <html>
                        <head><title><xsl:apply-templates 
                                    select="descendant::titleStmt/title"/></title>
                            <link rel="stylesheet" type="text/css" href="style.css"/> 
                        </head>
                        <body>
                            
                            <div id="reading-view">                      
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
    
    
    <!-- -->
    
    
    <xsl:template match="div[@type='page']">
        <section class="{@type}" id="page-{@n}">
            <xsl:apply-templates/>

        </section>
    </xsl:template>
    
    <xsl:template match="cbml:panel">
        <!-- EBB: Is this coded consistently in the source XML files? -->
        <div class="panel" id="page-{ancestor::div[@type='page']/@n}-panel-{@n}">
            <span class="tinyInfo">
              Character in this panel:
              <xsl:value-of select="@characters"/>
            </span>
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
    
    In Team Fortress code, the @who attribute is corresponding with the <name> element
    in the cmbl-si.xml, so that's what we're matching. You will likely need to change this
    for other projects.
    -->
        <div class="balloon">
            <span class="who" 
                title="{$site-index//*[name ! normalize-space() = current()/@who ! normalize-space()]/desc}">
                <xsl:value-of select="@who"/>
            </span>
            <xsl:apply-templates/>
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