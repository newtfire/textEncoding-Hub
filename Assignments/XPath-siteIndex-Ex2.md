# XPath Exercise 2: Exploring a big file with XPath

Our next exercise comes from a super long but simply structured file we've been developing for several years
for the [Digital Mitford project](https://digitalmitford.org), which is one of the first digital humanities projects I helped launch back in 2013. 
The project involves coding the personal letters, diary, and published writings of a 19th-century author who lived a long life and was very well connected wtih artists, theater managers, and publishers in London.
One reason we launched this big project is to keep track of all the proper names she mentioned in her writings and learn about her social network.
The document you'll be working with is basically full of lists storing our information and identifiers of people, organizations, places, events, and more that we've been identifying across our project. 
We'll use XPath to explore the lists and try out some XPath functions. 

 This exercise should help familiarize you with:
* using XPath to explore a big document and learn how it's coded
* practicing how to write predicate filters to limit your results
* using the `count()` and `position()` functions and comparison operators. 

### Getting Started: Opening the file in oXygen

Start this assignment by pulling in the textEncoding-Hub (`git pull`), and opening this file in oXygen:
Filepath: textEncoding-Hub/Class-Examples/XML/si-2023-10

You can also open the URL for this file directly in oXygen like this:
* Open oXygen. Go to **File >> Open URL**, and paste in this complete URL:
`https://raw.githubusercontent.com/newtfire/textEncoding-Hub/refs/heads/master/Class-Examples/XML/si-2023-10.xml`


### Prepare your XPath homework text file
Open a plain text file in oXygen by going to File >> New and searching for **Text**.
Save this using our homework filenaming conventions like this: beshero-xpath2.txt

### Getting ready to write XPath
You'll be using the XPath window to practice writing XPath expressions. Find it. 
Select the XPath 3.1 setting in the dropdown selections to the left of the XPath window. 

**Read and consult our introductory guide [Follow the XPath](https://newtfire.org/courses/tutorials/explainXPath.html) 
for help with constructing your expressions.**

Now, try writing XPath expressions in the XPath window to answer the following questions. 


**In your text file: Record the question numbers (or whole question if you wish), and 
paste in the XPath expressions that help answer the following questions.** 
If you are having trouble, explain what expressions you tried and sometimes that will help us 
figure out what went wrong and how to correct it.

1. This is a big document, so the Outline view in oXygen might lag for you. Instead, we'll use the XPath window.
Looking in the `//body` of the document, notice how the `<div>` elements divide it into sections. 
Write an XPath expression that returns a view of the `<div>` elements, and then filters it based on an attribute
so you only return the div holding entries on **historical persons** in the document.

2b. Find out all the child elements of the div that holds historical persons with XPath:
 Write an XPath that shows them to you even if you don't know/can't see the element names inside. (Hint: use the wildcard `*` character.)
 
2c. Switch this up to take a look inside a different `<div>` of your choice and return its children, whatever they are. 

2c. Okay, now let's take a look at all the possible child elements a `<div>` could have in this document. 
Record your XPath expression. The description in oXygen's results window shows you a number of results, but
try applying the `count()` function to your expression to return that number. 
Hint: You can either wrap the function around the whole expression, or use the XPath arrow operator `=>` to send the results to `count()`.

3a. Find the `<list>` element that holds all the animal entries. 
How many entries are inside that list? Record your XPath expression, and once again, try using the `count()` function to return a number.

3b. Okay,remove the `count()` function so you're returning the full sequence of elements on animals. 
Look up what the `last()` function does in our [XPath tutorial](https://newtfire.org/courses/tutorials/explainXPath.html), and apply it to your XPath: 
Which animal do you return? 

3c. Getting the hang of this? Write an XPath expression to return the 5th plant in the list of plants. 
Record your XPath and identify the plant.

3d. Okay, look up the `position()` function in [our XPath tutorial](https://newtfire.org/courses/tutorials/explainXPath.html). Notice how you can combine it with _comparison operators_ 
to test whether nodes are in a position *less than*, *less than or equal to*, *greater than*, etc. a certain number.
Following the examples in the tutuorial, write an XPath to return just **the first 6 entries in the list of plants**.

4. The following two XPath expressions return different results. Run each XPath expression, review the results, and explain what you think each expression is returning.
What do you think the parentheses are doing? 
`//person/occupation[1]`
`(//person/occupation)[1]`

5a. This set of questions explores how we coded the `<person>` elements in the file. First, how many `<person>` elmeents are in the whole document? 

5b. Are all of the `<person>` elements coded with an `@sex` attribute? Use a predicate filter with [ ] to find out and record your expression here. How many results do you see?

5c. XPath can work like a calculator: When you return numbers, XPath can handle simple arithmetic operations like add, subtract, multiply (with an `*`) , and divide (with the word `div`). 
With this information: 
* Write an XPath expression that returns the `count()` of person elements coded with `@sex` attributes, divided by the `count()` of all the person elements. 
* Multiply that by 100 to see a percentage: About what percentage of person elements are coded with @sex attributes in this document?

5d. Write an XPath expression to find the number of `<person>` elements coded as female with `@sex="f"`.
Use the `count()` function and division in XPath once again to find out the proportion of persons coded female among *all* the persons coded with the `@sex` attributes.






 
 
 







