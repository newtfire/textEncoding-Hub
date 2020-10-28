## XPath Exercise 1 Solutions

1. This Site Index file organizes lists of proper names of various kinds. Take a look at the outline view of the document before you begin to familiarize yourself with the structure of this file, and then work with XPath to answer the following:
1a. What XPath expression helps you to see all of the `<div>` elements in the document? (How many are there?)

**Answer**: `//div`  (9 results)

1b. Lists of persons are coded in `<listPerson>` elements. What XPath expression shows you all the `<listPerson>` elements in the document?

**Answer**: `//listPerson` (6 results)

1c. What XPath expression shows you which `<div>` elements contain child `<listPerson>` elements? (Use a predicate filter with square brackets `[ ]` to help you.) How many `<div>` elements contain `<listPerson>` elements inside?

**Answer**: `//div[listPerson]` (4 results)

1d. How can you change your XPath expression to return `<div>` elements that contain `<listPlace>` elements inside?

**Answer**: `//div[listPlace]` (1 result)

1e. Now, write an XPath to return all the `<place>` children of the `<listPlace>` elements. How many are there?

**Answer**: `/listPlace/place` (204 results)

1f. What is the difference between these two XPath expressions?
```
//place/placeName

//place//placeName
```
Enter the two and inspect the results. Why does the second expression return a larger number of results than the first?

**Answer**: The first expression returns 263 results, while the second expression returns 400 results. the second expression returns more results because it looks more deeply "down the tree" through the descendant axis, so it is finding more `<placeName>` descendants, and not just immediate children of `<place>` elements.


2. When exploring a document with XPath, sometimes we are trying to find out what elements have a certain value or property. If we want to return an element in a certain position without knowing its name, we can just designate any element with `element()` or `*`. So, for example, `//*` returns all 32,711 elements in this document. (Try it and see.) Using this information, answer the following:
2a. What XPath shows you all of the immediate children (whatever they are) of `<div>` elements?

**Answer**: Either of these (return 19 results)
```
//div/*
```
or
```
//div/element()
```

2b. There is a list of animals in this document coded in `<list sortKey="animals">`. How can you return all the child elements of this particular list to each of the animals? (How many are there?)

**Answer**: `//list[@sortKey="animals"]/*` or `//list[@sortKey="animals"]/element()`  (results: 29)

2c. Write a single XPath expression that returns all the different elements that hold a `@sortKey` attribute. (Our answer uses a predicate filter `[ ]`.)

**Answer**: `//*[@sortKey]` or `//element()[@sortKey]` (19 results)
**Suggestion**: To see the element names, try the simple map operator (to process each single result one at a time) and apply the `name()` XPath function: `//*[@sortKey] ! name()`   (19 results)
To remove duplicate names, use the arrow operator (to process the whole *sequence* of results) and the XPath function `distinct-values()` : `//*[@sortKey] ! name() => distinct-values()` (6 different elements use the `@sortKey` attribute.)


3. This set of questions explores the `<person>` elements in the file.

3a. First, write an XPath expression that returns all the `<person>` elements. How many are there?

**Answer**: `//person` (1223 results)

3b. Are all of the `<person>` elements coded with an `@sex` attribute? Use a predicate filter with `[ ]` to find out and record your expression here. How many results do you see?

**Answer**: `//person[@sex]` (1107 results: no, not all `<person>` elements are coded with a `@sex` attribute.)

3c. Apply a `count()` function to your previous expressions to return just a number in the XPath window.

**Answer**: Both of these work:
XPath 3.0 with arrow operator: `//person[@sex] => count()` (1107)
XPath 2.0 wrapper: `count(//person[@sex])`  (1107)

3d. XPath can work like a calculator: It can handle simple arithmetic operations like add, subtract, multiply (with an `*`) , and divide (with the word `div`). Try writing an expression that returns the `count()` of person elements coded with `@sex` attributes divided by the `count()` of all the person elements. Multiply that by 100 to see a percentage: About what percentage of person elements are coded with @sex attributes in this document?

**Answer**: Either of these works:
```
//person[@sex] => count() div //person=> count() * 100
```
or
```
count(//person[@sex]) div count(//person) * 100
```
(About 90.5% of `<person>` elements are encoded with an `@sex` attribute.)

3e. Write an XPath expression to find the number of `<person>` elements coded as female with `@sex="f"`.

**Answer**: Either of these works:
```
//person[@sex="f"] => count() div //person => count() * 100
```
or
```
count(//person[@sex="f"]) div count(//person) * 100
```
(About 26.7% of `<person>` elements in this document are encoded as female.

3f. Use the `count()` function and division in XPath once again to find out the proportion of persons coded female among all the persons coded with @sex attributes.

**Answer**: Either of these works:

```
//person[@sex="f"] => count() div //person[@sex] => count() * 100
```
or
```
count(//person[@sex="f"])  div count(//person[@sex]) * 100
```
About 29.5% of `<person>` elements encoded with the `@sex` attribute are marked as female.
