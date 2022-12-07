<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    version="3.0"
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xhtml"
        html-version="5" 
        omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <!-- 2022-12-07 ebb: I'm adapting a project XSLT stylesheet from the Fall 2022 More Beasts for Worse Children project to create a simple table that surveys some of the interesting markup in the project. 
        This is based on distinct values() : 
        The XSLT answers a question: How many different phrases did the team mark across the collection with:
       * <beast>
       * <person>
       * <act>
       * <event>
       And, which poems mention each distinct reference? 
       
       (The project team might well want to investigate other kinds of markup: I'm just sampling these for now to see what they show us!
       We'll make three HTML tables with this, two columns each: with the word/phrase on the left, and the list of poems mentioning it on the right. And wwe can link to the poems, of course, to create another way to navigate the collection. 
    -->
   
    <xsl:variable name="poemColl" 
        as="document-node()+" 
        select="collection('xml_document/?select=*.xml')"/>
    
    <xsl:variable name="beastMarkup"
        as="xs:string+"
        select="$poemColl//beast ! lower-case(.) ! normalize-space() => distinct-values() => sort()"/>
    
    <xsl:variable name="personMarkup"
        as="xs:string+"
        select="$poemColl//person ! normalize-space() => distinct-values() => sort()"/>
    
    <xsl:variable name="actMarkup"
        as="xs:string+"
        select="$poemColl//act ! normalize-space() => distinct-values() => sort()"/>
    
    <xsl:variable name="eventMarkup"
        as="xs:string+"
        select="$poemColl//event ! normalize-space() => distinct-values() => sort()"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>DIGIT 110 | <xsl:apply-templates select="$poemColl//bookTitle"/></title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="style.css"/>
                
            </head>
            <body>
                <!-- Credit: https://www.w3schools.com/howto/howto_js_scroll_to_top.asp -->
                <button onclick="topFunction()" id="to-top" title="Go to top"><img alt="up arrow" src="https://cdn.onlinewebfonts.com/svg/img_231938.png" width="30"/></button>
                <script>
                    // Get the button
                    let mybutton = document.getElementById("to-top");
                    
                    // When the user scrolls down 20px from the top of the document, show the button
                    window.onscroll = function() {scrollFunction()};
                    
                    function scrollFunction() {
                    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    mybutton.style.display = "block";
                    } else {
                    mybutton.style.display = "none";
                    }
                    }
                    
                    // When the user clicks on the button, scroll to the top of the document
                    function topFunction() {
                    document.body.scrollTop = 0;
                    document.documentElement.scrollTop = 0;
                    }
                </script>
                
                <nav id="menu">
                    <a href="index.html"><div class="button">Home</div></a>
                    <a href="fulltext.html"><div class="button">Fulltext</div></a>
                    <a href="gallery.html"><div class="button">Gallery</div></a>
                    <a href="bio.html"><div class="button">Biography</div></a>
                    <a href="https://github.com/JiayuanWen/Belloc-More-Beasts"><div class="button">Github <img alt="github icon" src="https://logos-download.com/wp-content/uploads/2016/09/GitHub_logo.png" width="15"/></div></a>
                    <a href="https://www.gutenberg.org/cache/epub/27176/pg27176-images.html"><div class="button">Project Gutenberg</div></a>
                </nav>
                
                <!-- Title -->
                <h1 id="top"><xsl:apply-templates select="$poemColl//bookTitle"/></h1>
                
                <!-- Table of Contents (Further implementation at ToC rules below) -->
                <section id="toc">
                    <h2 id="toc">Surveying the markup</h2>
                  <p>What did the team mark in each of the categories, and how often are particular words/phrases that we marked repeated across multiple poems in the collection?  In the XML we tagged: </p>
                    <ul>
                        <li>beast</li>
                        <li>person</li>
                        <li>act</li>
                        <li>event</li>
                    </ul>
      
                    
                <h3>Beast</h3>    
                    
                    <table id="beasts"> 
                        <tr>
                            <th>Tagged word or phrase</th>
                            <th>Poem(s) in which this word/phrase appears</th>
                        </tr>
                       
                        
                   <xsl:for-each select="$beastMarkup">
                       <!-- current() refers to the current word/phrase in the sequence.
                       We'll make a local variable to help find all the poems that mention this.
                       -->
                       <xsl:variable name="poemList" as="element()*" select="$poemColl//root[contains(. ! lower-case(.) ! normalize-space(), current())]//title[1]"/>
                         <tr> 
                           <td><xsl:value-of select="current()"/></td>  
                           
                          <td><!--Let's output a tidy list of the poems that mention the current word/phrase -->
                              <ul class="table">
                                  <xsl:for-each select="$poemList">
                                      <!--Let's go through each member of this sequence: and make a link to it in the HTML output on the reading view fulltext.html page. -->
                                      
                                      <li>
                                          
                                         <a href="fulltext.html#{current()/parent::pg/@ref}"><xsl:value-of select="current()"/></a>
                                      
                                      </li>
                                 
                                  </xsl:for-each>
                             </ul>
                              
                           </td>
                         </tr>
                   </xsl:for-each>
                            
                    </table>
                </section>
                
            
                
                <!-- Creative Common print -->
                <section id="copyright">
                    <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="GNU Public License e" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />
                </section>
            </body>
        </html>
    </xsl:template>
    
    <!-- Text view rules -->
    <xsl:template match="root/pg/title"> <!-- <h2> on poem titles -->
        <h2 id="{//pg/@ref => distinct-values()}"><a href="#top"><xsl:apply-templates/></a></h2>
    </xsl:template>
    <xsl:template match="root/pg/lg"> <!-- Wrap every line group with <p> -->
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="root/pg/lg/l"> <!-- Line break after each line -->
        <xsl:apply-templates/><br/>
    </xsl:template>
    <xsl:template match="root/pg/pgNum"> <!-- Line break after page number to prevent content overlapping with that of next page-->
        <xsl:apply-templates/><br/><br/>
    </xsl:template>
    <xsl:template match="root/pg/fig"> <!-- Deal with images-->
        <img alt="{img/@alt}" src="{img/@src}"/>
    </xsl:template>
    
    <!-- ToC rules-->
    <xsl:template match="root" mode="toc">
        <tr>
            <td class="table-title">
                <h2 >
                    <a href="#{//pg/@ref => distinct-values()}"><xsl:apply-templates select="pg/title" mode="toc"/></a>
                </h2>
            </td>
            <td class="table-page">
                
            </td>
        </tr>
    </xsl:template>
    
    
    
</xsl:stylesheet>