<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">

    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes"/>
<!-- **************************************************************************-->
<!-- 2026-11-19 ebb: This XSLT starter file is for the XSLT test in DIGIT 110.
    Do not alter the stylesheet root element or the output line.

    The XML markup provided is optimized for a study of technological devices mentioned
    in Bram Stoker's novel Dracula.

   Your task is to transform the source XML document into HTML with an informative
   table of contents linked to a reading view, and styled with CSS. Specifically,
   your XSLT code needs to:
   * Process our source XML file and output one valid and well-formed HTML file;
   * Contain an HTML table for the table of contents featuring:
        * each chapter heading, linked to that chapter in the reading view
        * each chapter's distinct, sorted technologies (marked with a <tech> element)
        * paired with a count of how many times each technology is mentioned in that chapter;
   * Contain span elements in the reading view to style the persons, places, dates, times,
     and technologies mentioned.
   * Prepare CSS to style your HTML. The XSLT should output the CSS link line to your CSS file accurately.
    -->
    <!-- **************************************************************************-->

 <xsl:template match="/">
     <html>
         <head>
             <title>Dracula</title>
             <link rel="stylesheet" type="text/css" href="style.css"/>
         </head>
         <body>
           <h1 id="top"><!-- ebb: Use XSLT to pull the title of the novel as represented in the XML file here --></h1>

             <!-- Table of contents. -->
             <section id="contents">
                 <table>
                 <tr>
                     <th>Chapter Number</th>
                     <th>Technology Table</th>
                 </tr>

            <!-- ebb: Apply templates to each descendant chapter element here, in mode="toc".
                 Each chapter will output ONE table row (<tr>) from the template rule below.  -->


             </table>
             </section>


             <section id="readingView">

                <!-- ebb: Apply templates to the same descendant chapter elements here,
                    but this time WITHOUT a mode, to start processing the reading view.  -->
             </section>
        </body>

     </html>
 </xsl:template>

    <!-- ******************************************************************* -->
    <!-- TABLE OF CONTENTS: template rules with mode="toc"                     -->
    <!-- ******************************************************************* -->

   <!--ebb: In the table of contents, we want each chapter's row to hold a sub-table
       (a table nested inside a table cell) listing each distinct technology
       with the number of times it is mentioned in that chapter, something like this:

       ___________________________________
       | CHAPTER    | TECH               |
       __________________________________|
       | Chapter I  |  __________________|
       |            | | CARRIAGE  | 4   ||
       |            | | LAMP      | 2   ||
       |            | | TRAIN     | 4   ||
       |            | |__________________|
       __________________________________|
       | Chapter II | ___________________
       |            | | COMPASS    | 1  ||
       |            | | LAMP       | 4  ||
       |            | |__________________|
       |___________________________________

   -->

    <xsl:template match="chapter" mode="toc">

        <!-- HINT 1: Before you start an <xsl:for-each> over distinct-values(), store the
            chapter you are processing in a variable. (Why? See HINT 3 below.)
            HOLIDAY GIFT: We've written this one for you: :-) -->
        <xsl:variable name="currentChap" as="element(chapter)" select="current()"/>

        <tr>
            <td><!-- Output the chapTitle here, wrapped in an <a href="#..."> that points to
                the @id you will give this chapter's heading in the reading view. --></td>

            <td>
                <!-- HINT 2: A table inside a table cell is just a complete <table> element
                    placed inside a <td>. It gets its own <tr>, <th>, and <td> elements. -->
                <table>
                    <tr>
                        <th>Technology</th>
                        <th>Count</th>
                    </tr>

                    <!-- Write an <xsl:for-each> here over the distinct values of the <tech>
                        elements in this chapter. Sort them, and output one <tr> per distinct
                        technology, with two <td> cells: the technology, and its count.

                        Look closely at the whitespace inside the <tech> elements in the source XML
                        before you decide what to feed to distinct-values()!

                        HINT 3: Inside <xsl:for-each select="distinct-values(...)">, the context
                        item (.) is a plain STRING, not a node in the XML tree. A string has no
                        descendants, so a path like .//tech will fail with an error
                        (XPTY0020: "the context item is not a node").
                        To get back into the chapter, start your path from your variable:
                        $currentChap//tech[ ... ]

                        HINT 4: Inside that predicate [ ... ], the dot (.) means each <tech> element
                        being tested. To refer to the distinct string your for-each is currently on,
                        use the current() function.
                    -->

                </table>
            </td>
        </tr>
    </xsl:template>

    <!-- ******************************************************************* -->
    <!-- READING VIEW: template rules with NO mode                             -->
    <!-- ******************************************************************* -->

    <!-- ebb: Write template rules for <chapter>, <chapTitle>, <p>, and the inline elements
        (<tech>, <loc>, <person>, <date>, <time>) here. Remember the <chapTitle> needs an @id
        that matches the href you wrote in the table of contents. -->

    <!-- ******************************************************************* -->
    <!-- PART 2: splitting the output with xsl:result-document                 -->
    <!-- ******************************************************************* -->
    <!-- ebb: Save this file as dracula.xsl for Part 1. Start Part 2 only after your single-page 
        output works, validates, and is COMMITTED and pushed. Then copy dracula.xsl to 
        dracula-split.xsl, commit the copy, and make the Part 2 changes in the copy.

        <xsl:result-document href="..."> writes everything inside it to a separate file.
        Each one must contain a complete HTML document: <html>, <head> with <title> and
        CSS link line, and <body>.

        * Where you put the result-document decides what content outputs to each file:
          - around the table-of-contents page in the root template  ->  site/index.html
          - inside your reading view chapter template  ->  one file per chapter.
            You can build each file name with an Attribute Value Template,
            much like how you built your @id values: href="multiPage/C{...}.html"

        * Then revise your links: when the target lives in a different file,
          an @href needs the file name, not just a #fragment.

        * Your pages will be in multiPage/, one folder below your CSS file: their CSS link 
          line needs a relative path that goes up a level.

        *  NOTE! When you set up xsl:result-document, REMOVE your output filename 
        from the oXygen XSLT file output window! (If both XSLT and oXygen try to write to 
        the same file name, the Saxon XSLT procesor could get confused and refuse to process.) -->

</xsl:stylesheet>
