<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
        indent="yes"/>

    <!-- 2022-11-28 ebb: This XSLT reads a collection of XML files and outputs **separate HTML files** for each XML file in the collection. 
        **We're working with the 2022 Behrend Travel Letters from Europe project.**
        
        * We'll introduce xsl:for-each here to loop through each file in the collection and output a new file. 
        * We'll block related images with each letter in the output HTML,
        * We'll also experiment with reaching into multiple directories to retrieve image files associated with each letter, 
        based on corellating file names
        * We'll use XPath function base-uri() to retrieve the file name, and then apply string functions to isolate the portion of the filename
        that matches up with the image file name in the docs/images/ directory,
        * We'll continue working with xsl variables to define filepaths to work with to reach into collections, this time of XML and of image files. 
    -->
    
    <!-- ******** GLOBAL VARIABLES FOR REACHING FOLDERS AND FILES WE NEED ******** -->
       
     <!--  ebb: Below is an xsl:variable set to store a collection of XML documents (stored in our file directory
    named xml-letters. We need to ignore everything except the XML files in that directory (so XSLT doesn't try to
    process the Relax NG schema), so the ?select="*.xml" selects only the XML files in the collection. -->

    <xsl:variable name="travelColl" as="document-node()+"
        select="collection('../XML-RNG/?select=*.xml')[base-uri()[contains(., 'page')]]"/>
    <!-- Some of the collection files aren't letter pages. There is an imageDesc file in here, too. So I added a predicate to filter only the 
    the ones whose filename contains 'page'. This uses the XPath base-uri() function which retrieves the filename for a document.-->
    
    
    <!-- ebb: Here's one more variable to reach just the team's imgDesc file when we need it. This XML file has coded descriptions of each
    image. -->
    <xsl:variable name="imgDesc" as="document-node()" select="doc('../XML-RNG/imgDesc.xml')"/>


    <xsl:template match="/"><!-- ebb: Set up the XSLT to run against any single XML file, so this 
    tmemplate has a document node to match on-->
       
       <!-- ebb: NOW we introduce xsl:for-each.
          *  xsl:for-each processes each member of a sequence one at a time.
          *  We commonly use it when xsl:template rules can't match on something: like something that is not a simple XML element node.
          *  You could use xsl:for-each to process each member of a sequence of sorted distinct-values if you like (these are off the XML tree of a document)
          *  We use it here to process files in a folder one at a time, and output a NEW HTML FILE for each XML file in it. 
          * Inside xsl:for-each, and inside xsl:template, the current() function captures the current single thing being processed. 
       -->
        
        <xsl:for-each select="$travelColl">
            <!-- Let's catch the filename for the current file in the collection being processed. 
                * For this we use the current() function. 
                * The @as attribute provides a datatype for the variable: Is it a kind of node? We should say what it is: 
                    document-node() in this case.
                * You don't technically need the @as attribute, but it is considered a best practice to include a type for your variables. 
            -->
            <!-- ***********LOCAL VARIABLES:  ************
                These variables are local because they change their values as xsl:for-each "turns" to process each new file in the collection. -->
            
            <xsl:variable name="currentFile" as="document-node()" select="current()"/>
           <!-- Here's another variable to return just a piece of string we want to use to match up with image files associated with this XML file.
                 * We'll use the base-uri() function to return its filename as a string
                 * Then we can use the substring-before() and substring-after() functions (or just the substring() function) to isolate exactly the bit of 
                 string we need that matches up with related image files in the project directory.
           -->
            
            <xsl:variable name="fileName" as="xs:string" select="$currentFile ! base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')"/>
            <xsl:variable name="matchString" as="xs:string" select="$currentFile ! base-uri() ! substring-after(., 'page') ! substring-before(., '.xml')"/>
            
            
            <!-- ******* OUTPUTTING A NEW HTML DOCUMENT USING XSL:RESULT-DOCUMENT  ******* -->
            <!-- Notice how the @href defines a file path relative to where this XSLT file is saved. 
                We're going to create a lettersOut subfolder in docs. 
                base-uri() outputs a full filepath like this: 
                file:/Users/eeb4/Documents/GitHub/newtfire/textEncoding-Hub/Class-Examples/XSLT/behrendTravel2022-images/XML-RNG/page6.xml
                
                So to get the portion we need to create a new filename, we use tokenize(), break the string on `/`, and select the very last piece.
                Then we cut the xml off the end (I like to use substring-before(., 'xml'). 
                
                The result for page6.xml should be: page6.
                
               We'll create a new file extension with html at the end: 
 
            -->
            <xsl:result-document method="xhtml" html-version="5" omit-xml-declaration="yes" include-content-type="no"
                indent="yes" href="../docs/lettersOut/{$fileName}.html" >
                
                <html>
                    <head>
                       <title>Letter <xsl:value-of select=".//letter/@n"/>
                           <xsl:if test=".//letter/@part">, Part <xsl:value-of select=".//letter/@part"/></xsl:if></title> 
                        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                        <!--ebb: The line above helps your HTML scale to fit lots of different devices. -->
                        <link rel="stylesheet" type="text/css" href="../style.css"/>
                        
                    </head>
                    <body>
                        <!-- DISPLAY area of the HTML file in the browser window -->
                        
                        <h1>Letter <xsl:value-of select=".//letter/@n"/>
                            <!-- ebb: We can use xsl:if to output something only if it's present or passes a condition 
                            we set. In this case, sometimes a page file is marked as *part* of a letter, so IF the @part
                            is present, we'll output a little more text using xsl:if: -->
                            <xsl:if test=".//letter/@part">, Part <xsl:value-of select=".//letter/@part"/></xsl:if></h1>
                        
                        <!-- Let's see if we can output images with text. We can just test and make sure our $matchString
                        value is what we expect: we need that to find the matching image file for the XML page being processed.
                        We'll remove this later, or output it in an xml comment using a cool feature called
                        <xsl:comment> . Try it!
                        -->
                     <xsl:comment>THE MATCH STRING IS <xsl:value-of select="$matchString"/></xsl:comment> 
                        
                        <!-- ebb: Let's pay attention to using HTML blocking elements to help control the layout.
                        Here we're setting up a nested structure using <section> and <figure> elements. We'll write
                        CSS to layout the figure on the left and the text on the right, using CSS display:flex property on the 
                        section.letterView.
                        -->
                        <section class="letterView">
                            
                            <figure>
                                <img src="../images/lfePage{$matchString}.jpg"/>
                                
                                <figcaption><!--something we pull from the imgDesc.xml file -->
                                <xsl:apply-templates select="$imgDesc//page[@n = $matchString]/desc"/>
                                </figcaption>
                                <!--CHECK is this pulling captions? Are all captions available? 
                                Are there ever multiple images per page? -->
                            </figure>
                            
         
                               <section class="letter"> 
                                   <xsl:apply-templates select=".//letter"/>
                               </section>
                       
                        </section>
                        <section class="navigation">
                            <!-- In here let's put links out to the other pages in the collection. -->
                            <ul>
                            <xsl:for-each select="$travelColl">
                                <li><xsl:value-of select="base-uri() ! tokenize(., '/')[last()] ! substring-before(., '.xml')"/></li>
          
                            </xsl:for-each>
                                
                            </ul>
                            
                            
                        </section>
                        
                        
                    </body>
                    
                </html>
    
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="letter">
        <div class="letterText">
        <xsl:apply-templates/>
        </div> 
    </xsl:template>
    
    <xsl:template match="place">
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="corr">
        <span class="corr" title="{@type}"><xsl:apply-templates/></span>
    </xsl:template>
        
       

</xsl:stylesheet>
