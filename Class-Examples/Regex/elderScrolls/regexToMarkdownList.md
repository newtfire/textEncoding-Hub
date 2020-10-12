## Regex patterns for upconverting elderscrolls list of text links into a Markdown list of links

Find `&` *didn't find any* 

Find `<` *didn't find any* 

Find `>` *didn't find any*

Find `\n\n+` 
Replace: `\n` *to close up extra lines and make the document uniform*

Find: ^.+\nhttps.+?$ . *to find all the characters on a first line, followed by a newline and https, then matching to the end of that line.

Set capturing groups: `^(.+)\n(https.+?)$`

Replace with: `* [\1](\2)` 
*The replace can use these literal special characters, the *, [, and ] that we couldn't use in the Find because they are needed to define regex patterns there.* 
*The replace also uses special characters to call on the capturing groups set by the parentheses in the Find.*

Save the file as scrolls.md and reopen to be sure the markdwon file is working correctly. 
Push to a GitHub repo to use as documentation there. 

