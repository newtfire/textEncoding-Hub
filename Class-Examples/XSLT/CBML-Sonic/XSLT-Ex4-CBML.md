# XSLT Exercise 2: A Reading view for CBML with a Character table: Part 1

This exercise introduces you to processing XML to output HTML with a very different structure.
It is also designed to help orient you to how to work with XML hierarchies to create template rules and output HTML structures to match.
We're working with project code from the Fall 2023 Text Encoding class's Sonic the Hedgehog project.

**Let's begin by accessing the files.** You can enter `git pull` on the textEncoding-Hub, and find the files for this assignment in:
* **Class-Examples >> XSLT >> CBML-Sonic**
* Inside this directory is 
  * a source XML document: [Sonic-issue01.xml](Sonic-issue01.xml)
  * a starter XSLT file: [CBML-to-HTML-XSL4-start.xsl](CBML-to-HTML-XSL4-start.xsl)
  * a starter CSS file: [style.css](style.css)
  * two different possible outputs:
      * [sonic-out-pageLinks.html](sonic-out-pageLinks.html)
      * [sonic-out-solution.html](sonic-out-solution.html)
* **Copy the source XML, XSLT, and CSS files to your own space**, or download them directly from the links above. 

In this first stage, we're going to be making a reading view of the source XML file. We're also planning to construct a linked "table of contents" for the file that helps locate specific characters. 
For this to work, we need HTML elements for sections of our output to have `@id` attributes. These will eventually be targets for `@href` attributes in our linked table of contents.
Study how this works by looking at the code for the output files linked above.

You may use our sample code or adapt this assignment to your own project code.
**If adapting this to your own project and it is NOT TEI or CBML**, be sure to remove the namespace processing lines from the XSL root element!

### Hints
* Start this assignment as you did [XSLT Exercise 3](https://newtfire.org/courses/tutorials/XSLTExercise-skyrim.html). 
* You'll probably have more template rules to write to process the different levels, and you should definitely work with more HTML 
block elements like `<section>`, `<div>`, and `<figure>` in addition to `<p>`. 
* Put `@class` attributes on your HTML elements to help you style them! 
* Set an `@id` on the HTML elements holding pages and panels: You will use that as a target for your links in the next stage of this assignment!
    * When you process the output for panels from the Sonic XML, you'll probably see an error about a "duplicate id" on one output panel. That's because there's a duplicate `@xml:id` in the source XML on a panel. Can you spot the source of the error? 
* Write CSS! We started you out with a CSS file linked to the stylesheet, so you can keep modifying it to make the output the way you want.



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