# XSLT Exercise 5: A Reading view for CBML with a Character table: Part 2
## Working with Modal XSLT and creating a simple table of contents

This exercise introduces you to processing XML to output HTML with a very different structure.
It is also designed to help orient you to how to work with XML hierarchies to create template rules and output HTML structures to match.
We're working with project code from the Fall 2023 Text Encoding class's Sonic the Hedgehog project.

**Let's begin by accessing the files.** You can enter `git pull` on the textEncoding-Hub, and find the files for this assignment in:
* **Class-Examples >> XSLT >> CBML-Sonic**
* Inside this directory is 
  * a source XML document: [Sonic-issue01.xml](Sonic-issue01.xml)
  * a starter XSLT file: [CBML-to-HTML-XSL5-start.xsl](CBML-to-HTML-XSL5-start.xsl)
  * a starter CSS file: [style.css](style.css)
  * a sample output file for this exercise, just showing each page and links to its panels.
  * In a third stage of this assignment, we'll fine-tune this! 
* **Copy the source XML, XSLT, and CSS files to your own space**, or download them directly from the links above. 

In this new stage of the assignment, we're going to work on outputting a table of information that links
down to specific panels in the Sonic document. 

### Overview:
We're going to try first to output a table of information that we're looking for. We'll modify it in stages.

At the top of the document, we'll set up an HTML `<table>`, and we'll set this up (for this exercise) with two side-by-side
columns using `<tr>` and two `<th>` elements inside that set up headings. 

Then we'll apply **Modal XSLT** to process the panel and page nodes in a different way than we did for the Reading View!

### Writing Modal XSLT

At the top of our document, we prepared a `<div id="table">` to hold a table of contents that we're now going to develop.

```xml
  <div id="table">
              <!-- ebb: Here inside this <div> is where we'll output the linked index or table of contents
              that points into the reading view panels -->
              
             
              <table>
                  <tr>
                      <th>Page</th>
                      <th>Panels</th>
                  </tr>
                 
                <!-- ebb: Here let's apply modal XSLT to process the div[@type='page'] elements differently
                than we did in the Reading View!  For this exercise, we want ONE table row for Every PAGE. -->

                  <xsl:apply-templates select=".//div[@type='page']" mode="toc"/>
         
                  
              </table>
      
          </div>     
```

I've added a new `@mode` attribute on `<xsl:apply-templates>` that puts a mode "label" on it. This basically says,
do NOT file the ordinary template rule for the `<div>` elements! Instead, process only the rules that are marked with another `@mode` with my value! 

So, later in the document, we're going to create a new template rule with a matching `@mode` attribute on it, like this:

```xml
<xsl:template match="div[@type]='page'" mode="toc">
  <!-- Fill in what you'd want to output to represent page information in the table cell! -->
  <tr>
    <td> <!-- PAGE info here --> </td>
    <td> <!-- process a list of panel info here! You can set up another template in @mode='toc' to do this! -->  </td>
  </tr>
</xsl:template>


```

For this assignment, see if you can get the Modal XSLT to work for you to output page info, and take one more step with your template rules to 
output panel info as well! 
In the next assignment we'll "step this up" to make a more complex index of character or sound or other information that you pull with distinct values.
That will be more complicated, but this is enough for a start! 


## Reminders: Setting up an XSLT Stylesheet to Output HTML, Coping with Namespaces

We've prepared a starter file to help you with this, but when you do this on your own for projects, notice these things:

* Your XSL root element needs to output HTML, and it needs the HTML namespace to be entered. See the xmlns pointing to the XHTML namespace?
* We have also applied the TEI and CBML namespaces in the root element. **NOTE: If you are adapting this to your project and you are NOT using CBML or TEI, you should remove the
namespace lines here, or your project code won't be processed!** 

```xml
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xpath-default-namespace="http://www.tei-c.org/ns/1.0"
xmlns:cbml="http://www.cbml.org/ns/1.0"
xmlns="http://www.w3.org/1999/xhtml"
version="3.0">
```

* Next we need a special **xsl:output** line. It looks like this: 

```xml
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
```

## Guide to Writing the XSLT Template Rules 


## General advice


* If you don’t get the results you expect and can’t figure out what you’re doing wrong, 
remember that you can post a query to our Digit-Coders Slack #xslt channel and/or to the [textEncoding-Hub Issues board[(https://github.com/newtfire/textEncoding-Hub/issues). You can’t just ask for the answer, though; you need to describe what you tried, what you expected, what you got, and what you think the problem is. We often find, just as we’re preparing to post our own queries to coding discussion boards, that having to write up a description of the problem helps us think it through and solve it ourselves, and the technical term for this is [rubber duck debugging](https://rubberduckdebugging.com/). Beyond just being patient rubber ducks, though, we’re also encouraging you to discuss the homework on the discussion boards because that’s also helpful for the person who responds. Answering someone else’s inquiry and troubleshooting someone else’s problem often helps us clarify matters for ourselves!

* When you complete this assignment, submit your XSLT file and your output HTML file to Canvas. You can bundle these in a zip file, following our usual homework file-naming conventions for the zip directory.
