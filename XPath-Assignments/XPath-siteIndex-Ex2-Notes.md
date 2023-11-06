# xPath assignment 2 notes

- For more xPath syntax, please check out: https://newtfire.org/courses/tutorials/explainXPath.html
    - When inputting a xPath command, you will recieve a sequence of nodes starting from 1 to the number of nodes searched. 
    
- 1a. This is a big document, so the Outline view in oXygen might lag for you. Instead, we'll use the XPath window. Looking in the //body of the document, notice how the `<div>` elements divide it into sections. Write an XPath expression that returns a view of the `<div>` elements, and then filters it based on an attribute so you only return the div holding entries on historical persons in the document.
    - `//div[@type="historical_people"]` 

- 2a. Find out all the child elements of the div that holds historical persons with XPath: Write an XPath that shows them to you even if you don't know/can't see the element names inside. (Hint: use the wildcard * character.)
    - `//div[@type="historical_people"]/*` 

- 2b. Switch this up to take a look inside a different `<div>` of your choice and return its children, whatever they are.
    - `//div[@type="fictional_and_archetypal"]/*` 

- 2c. Okay, now let's take a look at all the possible child elements a `<div>` could have in this document. Record your XPath expression. The description in oXygen's results window shows you a number of results, but try applying the count() function to your expression to return that number. Hint: You can either wrap the function around the whole expression, or use the XPath arrow operator => to send the results to count().
    - `//div[@type="Mitford_Team"] => count()`
    - `count(//div[@type="Mitford_Team"])`

- 3a. Find the `<list>` element that holds all the animal entries. How many entries are inside that list? Record your XPath expression, and once again, try using the count() function to return a number.
    - `//list[@sortKey="animals"]/item => count()`

- 3b. Okay,remove the count() function so you're returning the full sequence of elements on animals. Look up what the last() function does in our XPath tutorial, and apply it to your XPath: Which animal do you return?
    - `//list[@sortKey="animals"]/*[last()]`

- 3c. Getting the hang of this? Write an XPath expression to return the 5th plant in the list of plants. Record your XPath and identify the plant.
    - `//list[@sortKey="plants"]/*[5]`

- 3d. Okay, look up the position() function in our XPath tutorial. Notice how you can combine it with comparison operators to test whether nodes are in a position less than, less than or equal to, greater than, etc. a certain number. Following the examples in the tutuorial, write an XPath to return just the first 6 entries in the list of plants.
    - `//list[@sortKey="plants"]/*[position() le 6]`

- 4a. The following two XPath expressions return different results. Run each XPath expression, review the results, and explain what you think each expression is returning. What do you think the parentheses are doing? `//person/occupation[1] (//person/occupation)[1]`
    - `//person/occupation[1]` is finding each `<person>` node with its first `<occupation>` child. Finds many through out document.
    - `(//person/occupation)[1]` is finding the first `<person>` node with an `<occupation>` child. Only finds one. 

- 5a. This set of questions explores how we coded the `<person>` elements in the file. First, how many `<person>` elmeents are in the whole document?
    - `//person => count()`

- 5b. Are all of the `<person>` elements coded with an @sex attribute? Use a predicate filter with `[ ]` to find out and record your expression here. How many results do you see?
    - `//person[@sex]`

- 5c. XPath can work like a calculator: When you return numbers, XPath can handle simple arithmetic operations like add, subtract, multiply. With this information:
    - `(//person[@sex] => count())div(//person => count()) * 100`
    - `count(//person[@sex]) div count(//person)*100`

- 5d. Write an XPath expression to find the number of `<person>` elements coded as female with @sex="f". Use the count() function and division in XPath once again to find out the proportion of persons coded female among all the persons coded with the @sex attributes.
    - `//person[@sex="f"]`