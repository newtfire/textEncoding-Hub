<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>
    
    <!-- 2024-12-06 ebb: This introduces xsl:result-document, which lets you output multiple HTML files from a single XSLT. 
         
         <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
         indent="yes" href="{$yourDestinationDirectory}/{$filename}.html">
    -->



    <!-- ebb: This XSLT reads a collection of XML files and outputs a single HTML document assembling all
        the files into one HTML page. 
       
        Below is an xsl:variable set to store a collection of XML documents (stored in our file directory
    named xml-letters. We need to ignore everything except the XML files in that directory (so XSLT doesn't try to
    process the Relax NG schema), so the ?select="*.xml" selects only the XML files in the collection. -->

    <xsl:variable name="travelColl" as="document-node()+" select="collection('letters-xml/?select=*.xml')"/>

    <xsl:template match="/"><!-- ebb: We still need to set up the XSLT to run against any single XML file, so this 
    tmemplate has a document node to match on-->
        
       <!-- CONSTRUCT SOME TABLE OF CONTENTS TO FEATURE WHAT'S INSIDE AND LINK TO IT. THE TOC will be on its own page, or output 
       on the index.html page of the site!  -->
       
        <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
            indent="yes" href="docs/index.html">
            <html>
                <head>
                    <title>Behrend Archives Project</title>
                    <link rel="stylesheet" type="text/css" href="BAP_Style.css" />
                </head>
                <body>
                    <div class="navbar">
                        <a href="index.html">Home</a>
                        <a href="gallery.html">Gallery</a>
                        <div class="dropdown">
                            <button class="dropbtn">Read View<i class="fa fa-caret-down"></i>
                            </button>
                            <div class="dropdown-content">
                                <a href="Letter1.html">Letter 1</a>
                                <a href="Letter2.html">Letter 2</a>
                                <a href="Letter3.html">Letter 3</a>
                                <a href="Letter4.html">Letter 4</a>
                                <a href="Letter5.html">Letter 5</a>
                                <a href="Letter6.html">Letter 6</a>
                                <a href="Letter7.html">Letter 7</a>
                            </div>
                        </div>
                        <a href="About.html">About</a>
                        <a href="https://github.com/J-Banko/BehrendArchiveProject" target="_blank">GitHub</a>
                    </div>
                    <h1>Travels in Europe</h1>
                    <p>We will be documenting Mary Behrend's travel journals from the family's time in Europe.
                        Specifically their time in France.</p>
                    <p>Use the navbar above to navigate our site! We will have: a page with photos/scans of each of the pages of the journal, a page for each letter with a photo and read view, 
                        and a link to the GitHub repo containing the whole project.</p>
                    
                    <!-- HERE WE WILL CONSTRUCT THE TABLE OF CONTENTS FOR THE SITE -->
                   
                   <table>
                       <tr>
                           <th>Letter</th>
                           <th>Locations mentioned</th>
                       </tr>
                       
                    <xsl:for-each select="$travelColl">
                        <xsl:sort select="current()/base-uri()"/>
                        <xsl:variable name="letterName" as="xs:string" select="current() ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')"/>
                        <tr>
                            <td><a href="{$letterName}.html"><xsl:value-of select="$letterName"/></a></td>
                            <td><!-- Reach for distinct values of locations mentioned and output them here? --></td>
                            
                        </tr>
                        
                        
                    </xsl:for-each>
                    
                   </table>
                    
                </body>
            </html>
        </xsl:result-document>
        
        <!-- READING VIEW OUTPUT ON SEPARATE PAGES. We've output some id attributes that can be link targets from the TOC to the 
        output reading view pages -->
        <xsl:for-each select="$travelColl">
            <xsl:variable name="filename" as="xs:string" select="current() ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')"/>
            <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
                indent="yes" href="docs/{$filename}.html">
                
              <!-- base-uri() will retrieve the full filepath on my computer to the current XML that's being
              read here in the xsl:for-each. 
              We are going to need to trim the filepath down and isolate JUST the filename. We are also going
              to have to lose the file extension.
              
              XPath's tokenize() function lets you break a string into pieces based on a character divider.
              We'll tokenize based on the `/` in the URL. 
              -->
=
                <html>
                    <head>
                        <title><xsl:text>BTA: </xsl:text>
                            <xsl:value-of select="$filename"/>
                            <xsl:text> Read View</xsl:text></title>
                        <link rel="stylesheet" type="text/css" href="BAP_Style.css" />
                    </head>
                    <body>
                        <div class="navbar">
                            <a href="index.html">Home</a>
                            <a href="gallery.html">Gallery</a>
                            <div class="dropdown">
                                <button class="dropbtn">Read View<i class="fa fa-caret-down"></i>
                                </button>
                                <div class="dropdown-content">
                                    <a href="Letter1.html">Letter 1</a>
                                    <a href="Letter2.html">Letter 2</a>
                                    <a href="Letter3.html">Letter 3</a>
                                    <a href="Letter4.html">Letter 4</a>
                                    <a href="Letter5.html">Letter 5</a>
                                    <a href="Letter6.html">Letter 6</a>
                                    <a href="Letter7.html">Letter 7</a>
                                </div>
                            </div>
                            <a href="About.html">About</a>
                            <a href="https://github.com/J-Banko/BehrendArchiveProject" target="_blank">GitHub</a>
                        </div>
                        <section>
                            <div class="flex">
                                <div class="image-container">
                                    <figure>
                                        <!-- Ideally, we can reach into the XML for the current file and
                                        locate the image filename associated with it.-->
                                        <img src="Images/{$filename}.jpg" alt="page 1"/>
                                            <figcaption>Letter 1</figcaption>
                                    </figure>

                                </div>
                                <div class="letterText">
                                    <xsl:apply-templates select="descendant::meta"/>
                                    
                                    <xsl:apply-templates select="descendant::letter"/>
               
                                
                            </div>
                            </div>
                        </section>
        
                       
                    </body>

                    
                </html>
                
   
            </xsl:result-document>
            
        </xsl:for-each>
    
 
    </xsl:template>
    
    <!-- ************************************************* -->
    <!-- ebb: TOC mode templates for the table of contents -->
    <!-- ************************************************* -->
   
  
    


    <!-- ************************************************* -->
    <!-- ebb: templates for outputting the text of the letters -->
    <!-- ************************************************* -->
    
    <xsl:template match="meta">
        <h3><xsl:apply-templates select="title"/></h3>
        <ul>
            <li><xsl:apply-templates select="date"/></li>
            <li><xsl:apply-templates select="source"/></li>
            <li>Editors: 
                <ul>
                    <xsl:for-each select="editors/editor">
                        <li><xsl:apply-templates select="current()"/></li>
                    </xsl:for-each>
                </ul>  
            </li>
        </ul>
    </xsl:template>
    
    <xsl:template match="letter">
        <div class="transcript">
            <xsl:apply-templates/> 
        </div>   
    </xsl:template>
    
    <xsl:template match="p">
        <p id="p-{count(preceding::p) + 1}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="ln">
        <br id="ln-{count(preceding::ln) + 1}" /> 
        <span class="lineNum">
            <xsl:value-of select="count(preceding::ln) + 1"/>
            <xsl:text> </xsl:text>
        </span>
           
    </xsl:template>
    
    <xsl:template match="location">
        <span class="location" title="{@category}"><xsl:apply-templates/></span>
    </xsl:template>
   
   

</xsl:stylesheet>
