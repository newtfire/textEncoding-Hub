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
    <xsl:variable name="poemColl" 
        as="document-node()+" 
        select="collection('xml_document/?select=*.xml')"/>
    
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
                    <h2 id="toc">Table of Contents</h2>
                    <table> 
                        <tr>
                            <th>Title</th>
                            <th>Page</th>
                        </tr>
                        <xsl:apply-templates select="$poemColl//root" mode="toc">
                            
                        </xsl:apply-templates>
                    </table>
                </section>
                
                <!-- Text view -->
                <section id="fulltext">
                    <xsl:apply-templates select="$poemColl//root"/>
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
                <xsl:apply-templates select="pg[1]/pgNum/@n => distinct-values() => sort() => string-join('')" mode="toc"/>
            </td>
        </tr>
    </xsl:template>
    
    <!-- Element Highlights -->
    
    <xsl:template match="beast">
        <span class="beast">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="person">
        <span class="person">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="location">
        <span class="location">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="emot | act | desc | event[@con='pos']">
        <span class="pos">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="emot | act | desc | event[@con='neg']">
        <span class="neg">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="emot | act | desc | event">
        <span class="neutral">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
</xsl:stylesheet>