<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <!-- ebb: This XSLT reads a collection of XML files and outputs a single HTML document assembling all
        the files into one HTML page. 
       
        Below is an xsl:variable set to store a collection of XML documents (stored in our file directory
    named xml-letters. We need to ignore everything except the XML files in that directory (so XSLT doesn't try to
    process the Relax NG schema), so the ?select="*.xml" selects only the XML files in the collection. -->

    <xsl:variable name="nixonTranscripts" as="document-node()+"
        select="collection('nixon-transcripts/transcripts/?select=*.xml')"/>
    
 

    <xsl:template match="/"><!-- ebb: Set up the XSLT to run against any single XML file, so this 
    tmemplate has a document node to match on-->
        <html>
            <head>
                <title>Behrend Travel Letters</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <!--ebb: The line above helps your HTML scale to fit lots of different devices. 
                Below we include a basic CSS link association line. (Adapt this to your own CSS file.)
                -->
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <h1>Nixon Transcripts</h1>
                <section id="toc">
                    <h2>Contents</h2>
                    <table>
                        <tr>
                            <th>Transcript Title</th><!--first column table heading-->
                            <th>Transcript Date</th>
                            <th>People Speaking</th><!--second column table heading-->
                         <!--   <th>People Mentioned</th>--><!--third column table heading-->
                        </tr>
  
                        <!--ebb: Here we use our $nixonTranscripts variable pointing into the collection. -->
                        <xsl:apply-templates select="$nixonTranscripts//TEI" mode="toc">
    
                            <xsl:sort select="descendant::body/note/date/@when ! xs:date(.)"/>
                        </xsl:apply-templates>
                           
                
                        <!-- ebb: Notice how we open up xsl:apply-templates to apply xsl:sort. 
                            This sorts the files in the collection based on the
                      very first available @when on a date element. We convert it to xs:date to be sure
                      that XSLT sorts it as the proper datatype. 
                      -->
                        
                    </table>
                </section>

                <div id="fulltext">
                    <xsl:apply-templates select="$nixonTranscripts//TEI">
                        <xsl:sort select="descendant::body/note/date/@when ! xs:date(.)"/>
                    </xsl:apply-templates>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- ************************************************* -->
    <!-- ebb: TOC mode templates for the table of contents -->
    <!-- ************************************************* -->
   
   <xsl:template match="TEI" mode="toc" >
       <tr>
           <td><a href="#{descendant::titleStmt/title ! replace(., '\s+', '') }"><xsl:apply-templates select="descendant::titleStmt/title"/></a></td><!--first column data cell-->
           <td><xsl:apply-templates select="descendant::body/note/date[1]"/></td><!--second column data cell -->
           <td>People talking: <xsl:value-of select="descendant::body//u/@who ! normalize-space() 
                   => distinct-values() 
                   => sort() => string-join('!! ')"/></td>
           
       </tr>
   </xsl:template>
    


    <!-- ************************************************* -->
    <!-- ebb: templates for outputting the text of the letters -->
    <!-- ************************************************* -->
    
    <xsl:template match="TEI">
        <section id="{descendant::titleStmt/title ! replace(., '\s+', '') }" class="readingView">
         <h2><xsl:apply-templates select="descendant::titleStmt/title"/></h2>
       
        <div class="transcript">
             <xsl:apply-templates/>
         </div>
        </section>
        
    </xsl:template>
    

</xsl:stylesheet>






















