<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <!-- ebb: Suggestion: write new rules inside other <pattern> elements and keep this one distinct. -->

    <pattern id="check-ids-and-refs">
        <!-- 2026-11-04 ebb: This pattern is for checking that ref attributes are correctly resolving
             to the nixonReference.xml file. This version adds Schematron Quick Fix (SQF) so you 
             can pick a correct @xml:id from a menu. 
             (When this schema is applied, in oXygen you can right-click on a value yielding an error, 
             and look for "Quick Fix" in a menu to help you review options for correct encoding of your xml:ids pulled from your file! -->
        
        <let name="nixonRefIds"
            value="doc('metaInfo/nixonReference.xml')//@xml:id => distinct-values()"/>
        <!--ebb: nixonRefIds is a variable to store the location of the document storing your xml:ids.
            The path is relative to this Schematron file doc(). I've been recommending storing your ID file in a directory apart from your main collection
            of XML files that point to it because we often want to process them differently in a project! 
        -->

        <rule context="@who | @ref | @resp" role="info">
            <!-- Keep the raw tokens (with their #) so we know exactly which piece to replace. -->
            <let name="tokens" value="tokenize(normalize-space(.), '\s+')"/>

            <!-- A token is "bad" if it lacks the leading # OR what follows # isn't a defined id. -->
            <let name="badTokens"
                value="$tokens[not(starts-with(., '#') and substring-after(., '#') = $nixonRefIds)]"/>

            <assert test="empty($badTokens)" sqf:fix="pick-nixon-id">
                In <value-of select="current() ! name()"/>, these value(s) don't match an @xml:id in the nixonReference.xml:
                <value-of select="string-join($badTokens, ', ')"/>.
                Each value must be a # followed by a defined @xml:id.
                <!-- ebb: <value-of> lets us see something via XPath in the actual Schematron validation message!
                    string-join() is an XPath function that "glues" values together with a punctuation mark / separator of your choice. Here we're separating
                each "bad" token we find in an attribute value with a comma and space. -->
            </assert>

            <!-- ebb: Credits: I learned how to apply Schematron Quick Fixes and use-for-each 
                via Claude to improve my starter code. This might be a little extra complex, but
                I wanted this to allow you to code more than one value for when Nixon and friends
                are talking about multiple people like this: <name ref="#nixon #kissinger #haig">
                My guess is that you'll usually be encoding these values one at a time:
                
                <u who="#nixon">....</u>
                 
                 But this Schematron code can accommodate one or multiple values. 
                It doesn't matter what element name hosts these attributes b/c we're using the * wildcard.
        
                 I learned: use-for-each lets you make ONE quick fix per item in the sequence.
                 Each item is a string "badToken candidateId" (ids can't contain spaces,
                 so a space is a safe separator). Candidates are ids that share the first
                 three letters of the bad value; if none do, every id from nixonRef.xml is offered in the list.
                 And you don't have to choose any of them: you may need to go into the file and edit it
                 directly.
            -->
            <sqf:fix id="pick-nixon-id"
                use-for-each="
                    for $b in $badTokens return
                        let $stem := lower-case(substring(replace($b, '^#', ''), 1, 3)),
                            $near := $nixonRefIds[contains(lower-case(.), $stem)]
                        return
                            for $c in (if (exists($near)) then $near else $nixonRefIds)
                            return concat($b, ' ', $c)">
                <sqf:description>
                    <sqf:title>Replace "<value-of select="tokenize($sqf:current, ' ')[1]"/>"
                        with "#<value-of select="tokenize($sqf:current, ' ')[2]"/>"</sqf:title>
                </sqf:description>

                <!-- This part does the Quick Fix work: you rewrite the whole attribute, swapping only the bad token
                     and leaving any good tokens alone. -->
                <sqf:replace match="." node-type="attribute" target="{name()}"
                    select="string-join(
                                for $t in tokenize(normalize-space(.), '\s+')
                                return if ($t = tokenize($sqf:current, ' ')[1])
                                       then concat('#', tokenize($sqf:current, ' ')[2])
                                       else $t,
                            ' ')"/>
            </sqf:fix>
        </rule>
    </pattern>
    
    
</schema>
