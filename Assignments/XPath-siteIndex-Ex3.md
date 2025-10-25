# XPath Exercise 3: Functions and Predicates

Let's continue working with the same Digital Mitford project Site Index file that we used in XPath 2.

 This exercise should help familiarize you with:
* Writing more XPath functions and predicates
* Learning about *function signatures* (some functions a sequence of more than one, while some take only one node)
* Learning how to "pull" data from XML and make calculations with XPath


### Getting Started: (Re)-opening the file in oXygen

(If you have the si-2023-10.xml file open in oXygen already, just continue!) If not...Start this assignment by pulling in the textEncoding-Hub (`git pull`), and opening this file in oXygen:
Filepath: textEncoding-Hub/Class-Examples/XPath/si-2023-10

You can also open the URL for this file directly in oXygen like this:
* Open oXygen. Go to **File >> Open URL**, and paste in this complete URL:
`https://raw.githubusercontent.com/newtfire/textEncoding-Hub/master/Class-Examples/XPath/si-2023-10.xml`


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

1. Let's start by exploring the `count()` function a little differently. 
Up to this point we have been counting by sending an entire XPath sequence to the function, like this:
`count(//div)` or `//div => count()`
But what if we want to get counts of the elements inside a list, so we can see which lists have the most entries?
Try the following expressions, and then remove the `count()` function to see what nodes they are counting.
Then, explain what is being counted in each expression:
a. `//div/count(*)`
b. `//div/*/count(*)`
Why does this work? Think about where you position the `count()` in the XPath expression and why that matters.

2. Let's try using some new functions: `min()` and `max()`. These calculate the lowest and highest numerical values. 
To use `min()` or `max()`, you give the function a sequence of number values. 
Write an XPath expression that finds the maximum count of the items from our expression in 1b.
Record your XPath expression, and what's the maximum number?
Try it again on the `min()` and provide your XPath expression and the number.

3. Okay, that's not super useful information if we can't see what list it's from. 
How would you return the `<div>` element that contains the maximum count of list items? 
Hint: You'll need to use a predicate filter `[ ]` to test the `<div>` elements and see 
which one has *a count equal to the max number*. 
* Challenge: What if you don't know the number? Can you still write an expression that checks if the count is equal to the max count?
(Do your best and record your expressions, leave a comment if it worked or not!)

4. Okay, let's explore `distinct-values()`. This function removes duplicates from a sequence.
We can use it on this file to return all the `@type` attributes on the `<occupation>` elements, and remove the duplicates.
    a. Write an XPath expression that shows us the distinct values of `@type` on the `<occupation>` elements, and record your expression here.

    b. Now let’s connect two functions together! How can you return a `count()` of those `distinct-values()`? Record your XPath expression.


5. We can write XPath to identify people (pull records of `<person>` elements) based on their nested `<occupation>` elements and the attributes marked on those elements. 
You will need to write XPath expressions with predicates, and sometimes nested predicates to answer the following questions:

    a. Write an XPath expression that returns all the `<occupation type="artist">` elements.
    
    b. Now, let’s find the full listings of the artists themselves: How would you return the `<person>` elements that contain nested `<occupation type="artist">` markup?
    
    c. Who are the women artists listed in our site index? The `@sex` attribute on the <person> records "m", "f", or "u" recording conventional gender associations of the nineteenth century for "male", "female", or "undetermined". 
    Write an XPath expression that returns `<person>` elements when the @sex value is "f" *and* the nested `<occupation>` inside is the `@type` value of "artist". (Hint: you can write two predicates `[ ]` side by side, or you can use the boolean `and` in a predicate. 
    
    d. Who are the engravers in this site index? The `@subtype` attribute on the `<occupation>` element holds more specific occupation information. Write an XPath expression that finds all of the `<person>` elements with an occupation `@subtype` of "engraver".
    
    e. Study how the birth and death dates are stored in the person entries. Sometimes when the specific birth or death date is unknown, we have simply encoded a year value. Build on your previous XPath expression to locate who in the site index was an engraver born in the year 1787. 
    Record your expression. Who is the engraver?
    
    f. What XPath would return the birth dates of all the persons with occupation @subtype of "engraver" in the file?

    g. Use the simple map `!` operator to return the string value of the birth dates you located. Now, send all those dates through the XPath `sort()` function to sort them from earliest to latest. And let's add one more function to the chain: What happens when you add `min()` to the end? 
    Record your XPath expression. What is the earliest year in which an engraver listed in our file was born?

6. So far we've been looking at XPath functions that make calculations over a sequence of more than one item.
But some XPath functions are designed to test one node at a time and return information. Let's look at one of them.
The `name()` function returns the name of a node, the name of any elements or attributes.
    
    a. Write an XPath that returns all the names of every element used in this file! (Hint: use the wildcard `*` to get all the elements down the tree.) Record your expression.
    
    b. Now, remove the duplicates from that list of names using `distinct-values()`. You can also send that result to `count()`. How many different element names are we using in this entire file?


   





 
 
 







