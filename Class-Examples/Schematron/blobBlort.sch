<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
  <pattern>
        <rule context="blort" role="warning">
            <report test="count(blob) lt 3">WHYY??? WHY DO YOU THIS EVERY TIME? 
                We agreed that every blort element is supposed to contain at least
            three blob elements.</report> 
        </rule>
     
        
        <rule context="blob" role="error">
            <assert test="contains(., 'hi')">Oh no! The blob doesn't say "hi"! :-( </assert>
            
        </rule>
      
      <rule context="container" role="fatal">
          <assert test=".//tricky ! string-length(.) lt 10">
              My string-length should be less than 10! I TELL YOU!
          </assert> 
          <!-- Probably I should set my context on the tricky element to
          make this easier understand in the schema validation process. 
          You want your encoder to be able to find the error and correct it easily.
          -->
      </rule>
        
      <rule context="tricky" role="info">
         <report test="contains(., 'test')">
             Let me know when you see this word!
         </report>
      
      </rule>
      
        
    </pattern>
    
   
</schema>