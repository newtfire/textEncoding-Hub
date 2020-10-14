## Regex Exercise 1 Solution (in class)

Find `&` 
(Replace with `&amp;` if we find any)

Find `<` 
(Replace with `&lt;` if we find any)

Find `>` 
(Replace with `&gt;` if we find any)

Goal (what structure are we trying to make?)
```
           <table class="week">
               <tr id="2020-08-24">M 08-24</tr>
               <tr id="2020-08-26">W 08-26</tr>
               <tr id="2020-08-28">F 08-28</tr>
           </table>   
```
First we experimented with this powerful, "greedy" pattern:
Find (with dot matches all turned OFF): `^.+$`

Replace with: `<tr>\0</tr>`

Find: `<tr>\d{4}-\d{2}-\d{2}\t[A-Z]`
or we could use:
`<tr>\d{4}-\d{2}-\d{2}\t[MWF]`

Set the capturing groups ( )s in the Find:
``
(<tr)(>)(\d{4}-)(\d{2}-\d{2})\t([A-Z])
``
Replace:
`\1 id="\3\4"\2\5 \4`
(This is remixing the pieces I created with my capturing groups)

Now we need to set the `<table>` elements:
Find the first day of every week with just: 
Find: `<tr id=".+?">M`

Replace, using the close-open strategy:
`</table>\n<table>\0`
"clopening" the tables. :-)

Manually move the extra `</table>` to the end of the document.
Save it as `.xml`, and reopen it.

ALTERNATIVE find and replace for tr elements
Find: `^(\d{4}-)(\d{2}-\d{2})\t([MWF])`

Replace: `<tr id="\1\2">\3 \2</tr>`










