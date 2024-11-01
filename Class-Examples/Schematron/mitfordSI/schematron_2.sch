<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>

<pattern>
        <rule context="tei:person" role="info">
            <assert test="starts-with(@xml:id, (.//tei:surname)[1])">
                The xml:id does not contain the surname text.</assert>
        </rule>
    
    <rule context="tei:forename | tei:surname | tei:placeName | tei:persName[not(*)]" role="warn">
        <assert test="matches(., '^[A-Z]')">
            Check to see that these elements all start with a capital letter.
        </assert>
        
    </rule>
</pattern>
<pattern>
       <rule context="tei:person">
           
           <report test="tei:death/@when ! tokenize(., '-')[1] &lt; tei:birth/@when ! tokenize(., '-')[1]">
               Death year should never be earlier than birth year!!!
           </report>
           
       </rule> 
    
</pattern>


</schema>
