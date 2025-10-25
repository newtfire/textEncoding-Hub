# XPath Exercise 4: String functions and the Dot

 This exercise should help familiarize you with:
* Writing more XPath string functions and complex predicates
* When and how to work with the dot `.` notation in a function and in a predicate.
* Learning about *function signatures* (some functions a sequence of more than one, while some take only one node)
* Practicing how to "pull" data from XML and make calculations with XPath.


### Getting Started: (Re)-opening the file in oXygen

Start this assignment by pulling in the textEncoding-Hub (`git pull`), and opening this CBML file in oXygen:
Filepath: textEncoding-Hub/Class-Examples/CBML/Kaliman.xml

You can also open the URL for this file directly in oXygen like this:
* Open oXygen. Go to **File >> Open URL**, and paste in this complete URL:
`https://raw.githubusercontent.com/newtfire/textEncoding-Hub/master/Class-Examples/CBML/Kaliman.xml`


### Prepare your XPath homework text file
Open a plain text file in oXygen by going to File >> New and searching for **Text**.
Save this using our homework filenaming conventions like this: beshero-xpath2.txt

### Getting ready to write XPath
You'll be using the XPath window to practice writing XPath expressions. Find it. 
Select the XPath 3.1 setting in the dropdown selections to the left of the XPath window. 

**Read and consult Obdurodon's [The XPath Functions we Use the Most](http://dh.obdurodon.org/functions.xhtml), as well as our introductory guide [Follow the XPath](https://newtfire.org/courses/tutorials/explainXPath.html) 
for help with constructing your expressions.**

Now, try writing XPath expressions in the XPath window to answer the following questions. 


**In your text file: Record the question numbers (or whole question if you wish), and 
paste in the XPath expressions that help answer the following questions.** 
If you are having trouble, explain what expressions you tried and sometimes that will help us 
figure out what went wrong and how to correct it.


1. Write an XPath to find all the `@characters` attributes on the `<cbml:panel>` elements and take `distinct-values()`.
Inspect the results. Is this really removing all the duplicates? (Notice how the values are coded.)

2. Let's try the `tokenize` function to isolate each value. This is one of the "string functions" that needs to look inside
each node one at a time, and it needs to be constructed carefully to indicate what it is working on. 
Tokenize is designed to *split* values on (by default) spaces, and create a sequence out of them. Let's try it here. *Step-by-step*:
    * To write this, you have to tell `tokenize(.)` to process just one thing, and usually it's the *self* node that you navigate to.
In this case, that's each `@characters` attribute. 
    * Take your expression from 1. Remove `distinct-values()`. 
    * At the end of the expression you can use the simple map `!` operator to say, work on these nodes one at a time.
    * Then add the `tokenize(.)` function with a dot inside like that. The dot indicates that you're working on the *self* axis.
    * (Unlike the `name()` function, the string functions like tokenize(.) require the dot notation or a specific node inside the parentheses to process)
    * Take a look at your results. THEN, alter your XPath to return the distinct-values. Record the expression. (Better, yes?)

3. Let's try out the `contains()` function. This handy function lets you test nodes to see whether they contain a literal string of characters.
    * Look at how `contains()` is written in [The XPath Functions we Use the Most](http://dh.obdurodon.org/functions.xhtml). This function is the first one we've looked at together that takes *two arguments*. 
    * I think of this as like "finding a needle in a haystack": Indicate the one place you're searching in position 1, and the 'string-you're-searching-for' in position 2: 
`contains(haystack, needle)`
    * Usually we put `contains()` in a predicate filter. You can use the dot `.` to indicate that you want to search *here* in a particular node for the string. OR you can step to an element, and write in the attribute you want to check inside the first position of `contains()`
    * 3a. Armed with this information, use the `contains()` function to try finding all the panels that contain "drkelly" in the `@characters` value. Record your expression. How many do you find?
   * 3b. Try one other application of `contains()`, or its cousins `starts-with()` or `ends-with()` (your choice of elements or attributes--anything you want to find out from this file), and record your expression and what you find out.

4. Now let's look at the `string-length()` function. This handy function measures one string at a time. Let's try applying it
to the speech balloons in the CBML file to find out who has the longest and shortest speech in this comic.
* Step down to find all the `<cbml:balloon>` elements. 
* Use the simple map `!` operator to take each balloon one at a time, and apply `string-length()` to it. Record your expression.
* 4a. How long is the longest speech? Record an XPath expression that will give this value. Hint: Use a function we applied in XPath Ex 2.
* 4b. Again applying what you learned from XPath Exercise 2, how will you identify the character who delivers the longest speech? Write an XPath to filter the nodes based on the longest speech and tell you who is speaking. 
* 4c. Okay, if you go that, change one little thing in your expression so it tells you who delivers the *shortest* speech in this comic.(Record your XPath expression.) What is the character saying in the shortest speech?

5. Halloween special! 
  * 5a. Write an XPath that uses predicates and functions to tell you which `<cbml:panel>` in this comic book contains a `<note>` that **contains** the word "skull". Record your expression.
  * 5b. Okay, we have one more thing to tell you about the dot `.`  notation. Sometimes you need to filter your XPath nodes based on something about their **deep descendants**.
     When we do this, we need to use the `.` inside the predicate to indicate that XPath should filter based on the **current context**. 
    Try these two expressions, and do your best to explain why they return different results: How is the dot notation changing the expression?
      * `//div[//cbml:balloon[contains(., 'NO')]]`
      * `//div[.//cbml:balloon[contains(., 'NO')]]`
    
        (Think about this: Why does the first expression return a different number of results? What do you think the first predicate is doing?)
    
    





 
 
 







