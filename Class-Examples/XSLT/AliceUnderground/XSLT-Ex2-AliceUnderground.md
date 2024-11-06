# XSLT Exercise 2: Making an Image Directory for Alice's Adventures Underground

This exercise introduces you to processing XML to output HTML with a very different structure.
It is also designed to help orient you to how to work with XML hierarchies to create template rules and output HTML structures to match.
We're working with project code from the Fall 2023 Text Encoding class's Alice Underground project.

**Let's begin by accessing the files.** You can enter `git pull` on the textEncoding-Hub, and find the files for this assignment in:
* Class-Examples >> XSLT >> AliceUnderground
* Inside this directory is 
  * a source XML document: [AliceUndergroundCooler.xml](https://raw.githubusercontent.com/newtfire/textEncoding-Hub/master/Class-Examples/XSLT/AliceUnderground/AliceUndergroundCooler.xml)
  * a starter XSLT file: [Alice-to-ImageDirectory-HTML-starter.xsl](https://raw.githubusercontent.com/newtfire/textEncoding-Hub/master/Class-Examples/XSLT/AliceUnderground/Alice-to-ImageDirectory-HTML-starter.xsl)
  * a sample of the output: aliceImageDirectory.html
* **Copy the source XML and XSLT files to your own space**, or download them directly from the links above. 

First, here's our plan for an output HTML structure. It's a list of chapter headings with nested sub-lists of image URLs in each chapter.
You need to keep this output structure in mind as you develop your XSLT.

```html
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <title>Image Directory for Alice's Adventures Underground</title>
   </head>
   <body>
      <h1>An Image Directory for Alice's Adventures Underground</h1>
      <ul class="outerList">
         <li>Chapter I
            <ul class="sublist">
               <li>au-images/image_006.jpg</li>
               <li>au-images/image_009.jpg</li>
               <li>au-images/image_011.jpg</li>
               <li>au-images/image_013.jpg</li>
               <li>au-images/image_017.jpg</li>
               <li>au-images/image_019.jpg</li>
               <li>au-images/image_023.jpg</li>
               <li>au-images/image_024.jpg</li>
            </ul>
         </li>
         <li>Chapter II
            <ul class="sublist">
               <li>au-images/image_028.jpg</li>
               <li>au-images/image_031.jpg</li>
               <li>au-images/image_033.jpg</li>
               <li>au-images/image_035.jpg</li>
               <li>au-images/image_036.jpg</li>
               <li>au-images/image_037.jpg</li>
               <li>au-images/image_040.jpg</li>
               <li>au-images/image_043.jpg</li>
               <li>au-images/image_045.jpg</li>
               <li>au-images/image_046.jpg</li>
            </ul>
         </li><html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <title>Image Directory for Alice's Adventures Underground</title>
   </head>
   <body>
      <h1>An Image Directory for Alice's Adventures Underground</h1>
      <ul class="outerList">
         <li>Chapter I
            <ul class="sublist">
               <li>au-images/image_006.jpg</li>
               <li>au-images/image_009.jpg</li>
               <li>au-images/image_011.jpg</li>
               <li>au-images/image_013.jpg</li>
               <li>au-images/image_017.jpg</li>
               <li>au-images/image_019.jpg</li>
               <li>au-images/image_023.jpg</li>
               <li>au-images/image_024.jpg</li>
            </ul>
         </li>
         <li>Chapter II
            <ul class="sublist">
               <li>au-images/image_028.jpg</li>
               <li>au-images/image_031.jpg</li>
               <li>au-images/image_033.jpg</li>
               <li>au-images/image_035.jpg</li>
               <li>au-images/image_036.jpg</li>
               <li>au-images/image_037.jpg</li>
               <li>au-images/image_040.jpg</li>
               <li>au-images/image_043.jpg</li>
               <li>au-images/image_045.jpg</li>
               <li>au-images/image_046.jpg</li>
            </ul>
         </li>
 <!-- more list content ... -->
      </body>
      </html>
```

Basically you'll be creating an entirely new HTML structure out of the original XML documnt, and pulling just a few pieces of data from the original.
For this we'll be using the `@select` attribute on `<xsl:apply-templates>` to select ONLY the XML nodes we want to process.
And we'll be setting up a very special template that transforms the entire XML document into a much simpler / totally different HTML structure.

## Setting up an XSLT Stylesheet to Output HTML

We've prepared a starter file to help you with this, but when you do this on your own for projects, notice these things:

* Your XSL root element needs to output HTML, and it needs the HTML namespace to be entered. See the xmlns pointing to the XHTML namespace?


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

* If you used the identity transform stylesheet to start this, make sure you REMOVE the `<xsl:mode>` because this is a total transformation, not an identity transform!

## Guide to Writing the XSLT Template Rules 

Our XSLT transformation (after all this housekeeping) has three template rules:

1. We have a template rule for the document node (<xsl:template match="/">), in which we create the basic HTML file structure: 
the `<html>` element, `<head>` and its contents, and `<body>`—**anything that appears just once in the HTML document (one to one relationship with the root node)**. 
2. Inside the `<body> element` that we’re creating, we use <xsl:apply-templates> and select the `<chapter>` elements (using a literal XPath expression as the value of the `@select` attribute). And we create our wrapper `<ul class="outerList">` tags to set up the outside list of chapter headings.
3. We have a new template rule that matches the `<chapter>` elements and outputs the `<li>` that sits inside. This template reaches into each chapter and uses `<xsl:apply-templates select="..."/>` to reach for the `<head>` elements inside the chapters.
In that same template we also set up the nested sub-list for each chapter, a new `<ul class="sublist">`.
4. Finally, one last template rule matches on the `<image>` elements. NOTICE: the `<image>` elements in the Alice project are self-closing, so you need to use `@select` to reach for their attribute content.
   (Look at the `<image>` elements in the source XML to make sure you understand how to reach these attributes.)

## General advice

* If you have been reading more about XSLT or have some programming experience with other languages, you may have noticed that XSLT includes an `<xsl:for-each>` instruction that could be used to solve this problem. We are prohibiting its use for now; your solution must use `<xsl:template>` and `<xsl:apply-templates>` rules instead. There’s a Good Reason for this, which is to see how XSLT templates work, and later on we will discuss situations where you should use `<xsl:for-each>`, and a template rule would not work so well.

* If you don’t get the results you expect and can’t figure out what you’re doing wrong, 
remember that you can post a query to our Digit-Coders Slack #xslt channel and/or to the [textEncoding-Hub Issues board[(https://github.com/newtfire/textEncoding-Hub/issues). You can’t just ask for the answer, though; you need to describe what you tried, what you expected, what you got, and what you think the problem is. We often find, just as we’re preparing to post our own queries to coding discussion boards, that having to write up a description of the problem helps us think it through and solve it ourselves, and the technical term for this is [rubber duck debugging](https://rubberduckdebugging.com/). Beyond just being patient rubber ducks, though, we’re also encouraging you to discuss the homework on the discussion boards because that’s also helpful for the person who responds. Answering someone else’s inquiry and troubleshooting someone else’s problem often helps us clarify matters for ourselves!

* When you complete this assignment, submit your XSLT file and your output HTML file to Canvas. You can bundle these in a zip file, following our usual homework file-naming conventions for the zip directory.