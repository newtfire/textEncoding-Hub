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
       
       <!-- Below is an xsl:variable! It stores special information we need to process the collection of files.
           You access the variable in the XSLT using the $: $comicColl 
            Variable $comicColl is set to store a collection of XML documents (stored in our file directory
    named cbml-spidey. We need to ignore everything except the XML files in that directory (so XSLT doesn't try to
    process the Relax NG schema), so the ?select="*.xml" selects only the XML files in the collection. 
        
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
                            <th>Comic Book Page</th><!--first column table heading-->
                            <th>Characters</th><!--second column table heading-->
                        </tr>
                        
                        <xsl:apply-templates select="$comicColl//div[@type='page']" mode="toc">
                           
                        </xsl:apply-templates>
                        <!-- ebb: Notice how we open up xsl:apply-templates to apply xsl:sort. 
                            We can't be sure of the order of processing in a collection, so sorting is 
                            a good idea to make sure the pages show up in the correct numerical order. 
                            This sorts the files in the collection based on the @n on the div.
                      -->
                       
          
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
        <tr>
            <td><xsl:text>Page </xsl:text><xsl:apply-templates select="@n"/></td><!--first column data cell: to hold the page number. -->
            <td></td><!--second column data cell: to hold a sorted, string-joined list of persons mentioned. -->
        </tr>
   </xsl:template>
    


    <!-- ************************************************* -->
    <!-- ebb: templates for outputting the reading view of the comic book -->
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
