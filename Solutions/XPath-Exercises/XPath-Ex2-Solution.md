## XPath Exercise 2 Solutions

1. What XPath returns all the values of the `@type` attribute on the `<occupation>` elements?

**Answer**: `//occupation/@type`

2. Let's see if we can read that list of occupation `@type` values without duplicates. Apply the `distinct-values()` function to your XPath, and record your expression.

**Answer**: Either of these will work: 
```
//occupation/@type => distinct-values()
```
or 
```
distinct-values(//occupation/@type)
```
(This returns 15 items.)

3. Now let’s chain two functions together! How can you return a `count()` of those `distinct-values()` ? Record your XPath expression.

**Answer**: Our preferred way is:
```
//occupation/@type => distinct-values() => count()
```
but you may also do it the old-fashioned way: Read this from the inside out:
```
count(distinct-values(//occupation/@type))
```

4. We can write XPath to identify people (pull records of `<person>` elements) based on their nested `<occupation>` elements and the attributes marked on those elements. You will need to write XPath expressions with predicates, and sometimes nested predicates to answer the following questions:

4a. Let’s first find all the occupations marked with the attribute name-value pair: `type="artist"`. Write an XPath expression that returns all the `<occupation type="artist">`.

**Answer**: `//occupation[@type="artist"]`
(returns 66 items)

4b. Now, let’s find the full listings of the artists themselves: How would you return the `<person>` elements that contain nested `<occupation type="artist">` markup?

**Answer**: `//person[occupation[@type="artist"]]`

(Note the nested predicates. This returns 41 `<person>` elements.)

4c. Who are the women artists listed in our site index? The `@sex` attribute on the <person> records "m", "f", or "u" recording conventional gender associations of the nineteenth century for male, female, or undetermined. Write an XPath expression that returns `<person>` elements when the @sex value is "f" and the nested `<occupation>` is the `@type` value of "artist".

**Answer:** Either of these will work (and the predicate expressions can be in any order):

```
//person[@sex="f"][occupation[@type="artist"]]
```
or
```
//person[@sex="f" and occupation[@type="artist"]]
```
(returns 4 women artists)


4d. The `@subtype` attribute on the `<occupation>` element holds more specific occupation information. Write an XPath expression that finds all of the `<person>` elements with an occupation `@subtype` of "engraver".

**Answer**: `//person[occupation[@subtype="engraver"]]`
(returns 8 engravers)

4e. Study how the birth and death dates are stored in the person entries. Sometimes when the specific birth or death date is unknown, we have simply encoded a year value. Build on your previous XPath expression to locate the one person in the site index who was an engraver born in the year 1787. Who was it?

**Answer**: `//person[occupation[@subtype="engraver"]][birth/@when="1787"]`
William Finden is the engraver born in 1787.

4f. What XPath would return the birth dates of all the persons with occupation `@subtype` of "engraver" in the file?
**Answer**: This one is acceptable, but only returns seven of the engravers. 
`//person[occupation[@subtype="engraver"]]/birth/@when` 
We can broaden its scope, though! One of the `<birth>` elements for engravers is marked with another attribute, `@notbBefore`, so we can get them all this way:

```
//person[occupation[@subtype="engraver"]]/birth/@*
```
This expression returns the birthdays of all eight engravers.

4g. Use the simple map `!` operator to return the string value of the birth dates you located. Now, send all those dates through the XPath `sort()` function to sort them from earliest to latest. And let's add one more function to the chain: What happens when you add `min()` to the end? What is the earliest year in which an engraver listed in our file was born?

**Answer**: `//person[occupation[@subtype="engraver"]]/birth/@*`
The earliest birth date is Novmber 10, 1697.

5. Explain why the following two XPath expressions return different results. Run each XPath expression, review the results, and explain what you think each expression is returning.
```
//person/occupation[1]
```
```
(//person/occupation)[1]
```
**Answer**: The first expression locates the first `<occupation>` element inside each `<person>` elemnt. 
The second expression "walks the whole tree" first (that is what the parentheses are for), and then it pulls the very first one from the whole sequence of results. 

