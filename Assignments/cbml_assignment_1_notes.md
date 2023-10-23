# xPath assignment 1 notes

- For more xPath syntax, please check out: https://newtfire.org/courses/tutorials/explainXPath.html
    - When inputting a xPath command, you will recieve a sequence of nodes starting from 1 to the number of nodes searched. 

1. First, let's explore the CBML document in the Outline view in oXygen. (If you can't see the Outline view, go to Window >> Show View >> Outline.) Notice how the document is organized. Can you find the elements that hold a whole page, or "panel group" of the comic? The elements share this structure: `<div type="panelGrp">`. Write an XPath expression that finds all the elements that hold panel groups in this file.
    - Command: `//div[@type="panelGrp"]`
        - Make sure spelling is correct and quotation marks match
        - `@` symbol is for identifying attributes, not elements.

2. Use the expression that you wrote to answer 1, and "step down the tree" to find all the panels. Record your XPath expression. Notice that you need to use the cbml: prefix here. That is because these elements for panels are inside the CBML namespace.
    - Command: `//div[@type="panelGrp"]/cbml:panel`
        - When going down XML nodes, use one forward slash, then the following node you are looking for.
        
3. Let's try narrowing down the results with an XPath predicate, written with [ ] in your expression.
    - Command: `//div[@type="panelGrp"][position() = 2]` or `//div[@type="panelGrp"][2]`
        - Grabs the second `<div type="panelGrp">` in position of document.

4. Let's explore finding attributes. As you explore the XML, notice how characters are marked in the panels.
    - Command: `//*/@characters`
       - Grabs all elements with `@characters` attribute
       
5. Okay, usually we work with attributes to help filter elements. Let's say we want to find all the panels in which only the narrator is represented? Use an XPath predicate with [ ] to help return the panels that are only representing the narrator.
    - Command: `//cmbl:panel[@characters="narrator`
    
6. The `<floatingText>` element in CBML is a pretty exciting application of the TEI. It lets you nest a whole new "document" inside any level of the text you want. How are these useful in CBML? Let's take a look at them
    - Command: `//floatingText`
    - the `count()` function is really useful for recieving the number of searched nodes. There are two ways to execute.
        - Command: `//cbml:panel[floatingText] => count()` or
        - Command: `count(//cbml:panel[floatingText])`
