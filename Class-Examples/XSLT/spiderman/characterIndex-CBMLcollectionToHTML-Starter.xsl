<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs cbml"
    version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <!-- ebb: This XSLT reads a collection of TEI-CBML files and outputs a single HTML document assembling all
        the files into one HTML page. NOTE: To process the TEI and CBML, his XSLT contains a xpath-default-namespace attribute in the xsl:stylesheet to read TEI,
        and it contains the cbml namespace, too.-->
       
       <!-- Below are two xsl:variables! These store special information we need to process the collection of files.
           You access these variable in the XSLT using the $: $comicColl and $characters
           
          1. Variable $comicColl is set to store a collection of XML documents (stored in our file directory
    named cbml-spidey. We need to ignore everything except the XML files in that directory (so XSLT doesn't try to
    process the Relax NG schema), so the ?select="*.xml" selects only the XML files in the collection. 
         2. Variable $characters is set to reach into the $comicColl collection and pull the distinct values of all the characters who
         are speaking in the comic book. 
         Can you adapt this $characters variable to reach the characters as referenced in your own project? 
       -->

    <xsl:variable name="comicColl" as="document-node()+"
        select="collection('cbml-spidey/?select=*.xml')"/>
    
    <xsl:variable name="characters" as="xs:string+" select="$comicColl//cbml:balloon/@who ! normalize-space() => distinct-values()"/>

    <xsl:template match="/"><!-- ebb: In oXygen, we set up the XSLT to run against any single XML file, so this 
    tmemplate has a document node to match on. This will output one HTML file representing the whole collection.
    -->
        <html>
            <head>
                <title>Spiderman</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <!--ebb: The line above helps your HTML scale to fit lots of different devices. 
                Below we include a basic CSS link association line. (Adapt this to your own CSS file.)
                -->
                <link rel="stylesheet" type="text/css" href="comicStyle.css"/>
            </head>
            <body>
                <!--ebb: Here we use our $comicColl variable pointing into the collection. -->
                <h1><xsl:apply-templates select="($comicColl//titleStmt/title)[1]"/></h1>
                <section id="toc">
                    <h2>Contents</h2>
                    <!-- ebb: We're going to output a cast of characters and the pages numbers in the comic book 
                    on which they appear. (Drama people could adapt this to output characters and scene numbers on which they appear.)
                    -->
                    <table>
                        <tr>
                            <th>Characters</th><!--first column table heading-->
                            <th>Page Appearances</th><!--second column table heading-->
                         
                        </tr>
                        <!-- ebb: Okay! This is our first time using xsl:for-each. We need it because we pulled
                        distinct-values off of the tree and we want to walk through each one to make a cast list style
                        table of contents.  -->
                        <xsl:for-each select="$characters">
                            <tr>
                                <td><xsl:value-of select="current()"/></td>
                                <!-- current() is very special! It refers to the current item being processed,
                                either in for-each, or a template rule. -->
                                
                                <td><xsl:text>pages: </xsl:text>
                                 <xsl:apply-templates select="$comicColl//div[@type='page']
                                    [descendant::cbml:balloon/@who=current()]" mode="toc"/>
                                </td>
                                <!-- ebb: In the second table cell, we're going into the $comicColl collection
                                and looking up the div elements that hold balloons where the **current()** character
                                is speaking. (Can you adapt this code to reach the characters as referenced in your
                                own project? ) -->
                            </tr>
                        </xsl:for-each>
          
                    </table>
                </section>

                <section id="readingView">
                    
                    <xsl:apply-templates select="$comicColl//div[@type='page']"/>
                       
                </section>
            </body>
        </html>
    </xsl:template>
    
    <!-- ************************************************* -->
    <!-- ebb: TOC mode templates for the table of contents -->
    <!-- ************************************************* -->
   
   <xsl:template match="div" mode="toc">
    <xsl:apply-templates select="current()/@n"/>
       <xsl:if test="not(position() = last())">
           <xsl:text>, </xsl:text>
       </xsl:if>
       <!-- Above is a special <xsl:if> test: It looks to see if the current() matched <div> is NOT the last one 
       being processed by the template. If it's the last one, it won't pass the test, and there will be no comma output.-->
      
   </xsl:template>
    


    <!-- ************************************************* -->
    <!-- ebb: templates for outputting the text of the letters -->
    <!-- ************************************************* -->
    
    <xsl:template match="div">
        <section class="pageBlock">
           <xsl:apply-templates/>
        </section>
    </xsl:template>
    <xsl:template match="cbml:panel">
        <div class="panel">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
   

</xsl:stylesheet>
