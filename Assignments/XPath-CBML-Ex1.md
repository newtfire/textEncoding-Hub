# Learning XPath with CBML: XPath Orientation Exercise 

Dr. Felipe Gómez has been working on a CBML project 
working with the paper/print Latin American Comic Books Archive at Carnegie Mellon University Libraries.
They prepared a CBML archive of some of the comics in the archive, 
featuring comics from Colombia, Argentino, Mexico, and Ecuador. (In case you're curious, here is [an article with more information about the project](https://networks.h-net.org/node/23910/blog/research-corner/11109455/blog-latin-american-comics-archive-digital-collection).)  
This XPath exercise is designed to
work with one of the CBML files in Gómez's project, representing the _Los Agachados_ comic by Chompas Rius, and you can see 
[some page images from one of the issues here](https://www.ebay.com/itm/184682373528) . This exercise should help familiarize you with:
* basic XPath expressions to find XML nodes
* the structure and content of CBML TEI files
* exploring XML documents with multiple *namespaces* (CBML and TEI) 

### Getting Started: Opening the file in oXygen

Start this assignment by pulling in the textEncoding-Hub (`git pull`), and opening this CBML file in oXygen:
Filepath: textEncoding-Hub/Class-Examples/CBML//Latin-American-Comics-Archive/los-agachados.xml 

You can also open the URL for this file directly in oXygen from GitHub like this:
* Open oXygen. Go to **File >> Open URL**, and paste in this complete URL:
`https://raw.githubusercontent.com/newtfire/textEncoding-Hub/refs/heads/master/Class-Examples/CBML/Latin-American-Comics-Archive/los-agachados.xml`

### Prepare your XPath homework text file
Open a plain text file in oXygen by going to File >> New and searching for **Text**.
Save this using our homework filenaming conventions like this: beshero-xpath1.txt

### Getting ready to write XPath
You'll be using the XPath window to practice writing XPath expressions. Find it. 
Select the XPath 3.1 setting in the dropdown selections to the left of the XPath window. 

**Read and consult our introductory guide [Follow the XPath](https://newtfire.org/courses/tutorials/explainXPath.html) 
for help with constructing your expressions.**

Now, try writing XPath expressions in the XPath window to answer the following questions. 
**In your text file: Record the question numbers (or whole question if you wish) in your Text file, and 
paste in the XPath expressions that help answer the following questions.**

1. First, let's explore the CBML document in the Outline view in oXygen. (If you can't see the Outline view, go to 
 Window >> Show View >> Outline.) Notice how the document is organized.  Can you find the elements that hold a whole page, or "panel group" of the comic? 
The elements share this structure: `<div type="panelGrp">`. Write an XPath expression that finds all the elements that hold panel groups in this file.

2. Use the expression that you wrote to answer 1, and "step down the tree" to find all the panels. Record your XPath expression.
 Notice that you need to use the `cbml:` prefix here. That is because these elements for panels are inside the CBML namespace.

3. Let's try narrowing down the results with an **XPath predicate**, written with `[ ]` in your expression.
* Write an XPath that will return only the second panel group (literally the second whole page) in the document. You can use a position marker: `[2]`
* Now, build on that expression to return only the `<cbml:panel>` elements inside that second panel group. 
* How many results do you return? 

4. Let's explore finding attributes. As you explore the XML, notice how characters are marked in the panels.
* Write an XPath expression that returns all the values of the `@characters` attribute. 
* How many results do you see?

5. Okay, usually we work with attributes to help *filter* elements. Let's say we want to find all the panels in which 
only the narrator is represented? Use an XPath predicate with `[ ]` to help return the panels that are only representing the narrator. 

6. The `<floatingText>` element in CBML is a pretty exciting application of the TEI. It lets you nest a whole new "document" inside any level of the text you want.
How are these useful in CBML? Let's take a look at them?
* How many `<floatingText>` elements do you see?
* What kind of content do you think is being described here? (Take a guess if you're not sure--I know you can't see the whole comic.)
* How many panel elements contain floatingText elements? 
Write an XPath expression that uses a predicate `[ ]` to return *only* the `<cbml:panel>` elements that have a `<floatingText>` element inside.
* You can see the number of results in the return window, but let's try adding a *function* to your expression. Try applying the `count()` function to return a count of the number of panels that include floatingText.









