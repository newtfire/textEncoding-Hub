<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
 <!--2020-12-04 ebb: This XSLT models xsl:analyze string, while outputting a reading view of the Montage of a Dream Deferred poetry collection.
The xsl:analyze-string code is matching on a text() node, any text() node, and it is designed to match
on the phrase "dream deferred" to output it in an HTML <span class="motif"> which can be styled to highlight 
any time this phrase is used anywhere the poetry collection.
 -->   
    <xsl:template match="/">
        <html>
            <head>
                <title>Montage of A Dream Deferred</title>
                <link rel="stylesheet" type="text/css" href="hughproject.css"/>
                <link rel="stylesheet" type="text/css" href="https://use.typekit.net/jkx1xou.css" />
                <!--ebb: The second CSS link line is giving you your handwriting-style font, but you might want to explore some other options that are easier to read on a screen!
                This looks pretty good for the poem titles, but it's hard for the main title (with a series of flourishy capitals in a row),
                and the default size (for the words in the poems) is awfully small. -->
            </head>
            <body>
                <h1><xsl:apply-templates select="descendant::text/title[1]"/></h1>
                <!--It looks like you have two title elements, one way at the end of the document? So this one just catches the first one. -->
                <h2>by Langston Hughes</h2>
                
                <!--jkc:Table of Contents -->
                <section id="contents"> <table> 
                    <tr>
                        <th>Poem</th>
                        <th>Page Number</th>
                    </tr>
                    <xsl:apply-templates select="descendant::poem" mode="toc"/>
                    
                </table></section>
                <hr/>
                <!-- jkc: the actual poems -->
                <section id="readingView">
                    <xsl:apply-templates select="descendant::poem"/>
                </section>
                <!--ebb: If you want to output the code you marked as a title at the very end, you could uncomment this:
                 <h1><xsl:apply-templates select="descendant::text/title[2]"/></h1>
              -->
            </body>
        </html>
    </xsl:template>
    <xsl:template match="poem" mode="toc">
        <tr>
            <td><a href="#C{count(preceding-sibling::poem) + 1}"></a><xsl:if test="not(poem[@cont])"><xsl:apply-templates select="poemTitle"/></xsl:if></td>
            <td><xsl:apply-templates select="pb/@pNum"></xsl:apply-templates></td>
        </tr>
    </xsl:template>
    <xsl:template match="poem">
        <h2><xsl:apply-templates select="descendant::poemTitle"/></h2>
        <xsl:apply-templates select="descendant::line"/>
    </xsl:template>
    
 <xsl:template match="line">
     <p>
         <xsl:apply-templates/>
     </p>  
 </xsl:template> 
<!--2020-12-04 ebb: This template matches on text() nodes anywhere in your source XML, and analyzes them
    looking for the regex pattern "dream deferred", as a literal phrase. Anytime it finds those characters all together,
    it outputs an HTML <span class="motif">...</span> around the matching part, and it also outputs the non-matching part.
    -->   
    <xsl:template match="text()">
        <xsl:analyze-string select="." regex="dream deferred">
            <xsl:matching-substring> 
                <span class="motif"><xsl:value-of select="."/></span>
            </xsl:matching-substring>
            
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="[Ff]reedom"><!--ebb: I kept on going here to see if I could keep adding highlights to other phrases. This is how you do it.
                Set a new xsl: analyze string inside the non-matching substring, and keep on going, so each new one nests inside the non-matching substring of the previous analyze-string.-->
                    <xsl:matching-substring>
                        <span class="motif"><xsl:value-of select="."/></span>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
       
    </xsl:template>
    <!-- ebb: You could create as many of these as you like, but you have to set them in order and nest them like I did here, so I could pick up either capital or lower-case "Freedom" or "freedom" as well as "dream deferred". 
        And, of course, you can style your output <span> elements with CSS, maybe with colors or background colors or text-decoration effects
        .-->
    
    <xsl:template match="format">
        <xsl:variable name="formatProperty" as="xs:string+" select="@*/string()"/>
        <em class="{$formatProperty}"><xsl:apply-templates/></em> 
    </xsl:template>
    <!--ebb: Above is a new rule I wrote to simplify your procesing of <format> and its various attributes.
       This is applying a variable in XSLT to collect all of the attribute values of ANY attributes you have set on a format element anywhere in the document.
       Since you are outputting these all as values of @class in HTML, we can output multiple values so if something is indented
       and capitalized, you get both properties, separated by a space. Multiple @class values just come out like this and are pretty common to use in HTML:
        
        <em class="italics ind1">....</em>
       
       With the series of templates matching on <format> with each different attribute, you'd be getting one or the other value but not both. 
       Now you'll definitely get all the values, and your CSS styling should respond to them all.
       
       Your original XSLT was having trouble determining when to fire the several template rules you wrote below
        because quite often the @wordType and @margin attributes are on the same element. We were seeing an "ambiguous rule match" warning, 
        which didn't stop the XSLT, but I think it didn't completely process all your values.
        The XSLT was working, but it was only giving you *one* value most of the time, so it wasn't optimal.
        I hope this revised, single rule works out better for your HTML output.
        
       -->
    
    <!--ebb: This code below generated "ambiguous rule matches" so I'm commenting it out.  
        
        <xsl:template match="format[@wordType='italics']">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    <xsl:template match="format[@wordType='underline']">
        <em class="underline">
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    <xsl:template match="format[@wordType='caps']">
        <em class="caps">
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    <xsl:template match="format[@margin='ind1']">
        <em class="ind1">
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    <xsl:template match="format[@margin='ind2']">
        <em class="ind2">
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    -->
   
</xsl:stylesheet>