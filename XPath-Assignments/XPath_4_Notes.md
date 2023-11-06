# XPath Exercise 4 Notes

## Section 1
a.) `//cbml:panel/@characters => distinct-values()`

## Section 2
a.) `//cbml:panel/@characters ! tokenize(.)` (Tokenize is designed to handle one thing at a time)

Alternate Version - `//cbml:panel ! tokenize(@characters)`



## Section 3 
* Prenote: `contains()` is used to to filter elements almost like a Google search in XML

* Prenote: Typical Write-up for the contains functions: `contains(.,"string")`

* Prenote: ` starts-with(.)` ; ` ends-with(.)` are "cousins" `contains()` and follow the same syntax

a.) `//cbml:panel[@characters ! contains(.,"drkelly")]`

* Alternate Version: `//cbml:panel[contains(@characters,"drkelly")]`

* Optional Removing of '#' `//cbml:panel/@characters ! tokenize(.,'#')=>distinct-values()`

* Secondary Optional Removing of '#' `//cbml:panel/@characters ! tokenize(.)!substring-after(.,'#')`


b.) (Per Student Answer)

## Section 4
a.) `//cbml:balloon ! normalize-space()!string-length()` ; `normalize-space()` will remove space characters from being counted

* Fun Tip (Removing all caps writing style): `//cbml:balloon!lower-case(.)`


b.) `//cbml:balloon[string-length(.) = min(//cbml:balloon/string-length(.))`


c.) `//cbml:balloon[string-length(.) = max(//cbml:balloon/string-length(.))]`


## Section 5

a.) `//cbml:panel[note[contains(.,'skull')]]`

* Alternative Version: `//cbml:panel[note ! contains(.,'skull')]`

b.) The dot says "self", this means "stop here!" then continue down. 

`//div[//cbml:balloon[contains(., 'NO')]]` (Meaning: Go to the top of the tree and look at the whole document)

`//div[.//cbml:balloon[contains(., 'NO')]]` (Meaning: Go to div specifically and stop there and check those rather than the whole document)