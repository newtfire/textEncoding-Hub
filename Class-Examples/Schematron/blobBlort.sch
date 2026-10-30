<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
  <pattern>
        <rule context="blort" role="error">
            <report test="count(blob) lt 3">WHYY??? WHY DO YOU THIS EVERY TIME? 
                We agreed that every blort element is supposed to contain at least
            three blob elements.</report> 
            <!-- The <report> test fires when the condition you define is true. 
            You want a **report** any time this condition happens! 
            -->
        </rule>
        
        <rule context="blob" role="warning">
            <assert test="contains(., 'hi')">Oh no! The blob doesn't say "hi"! :-( </assert>
            <!-- The <assert> test only fires if the condition you describe is violated.
                <assert> wants to **check and make sure** that the condition
            you define is true, so if the test condition is NOT true, it fires.
            I think of <assert> as **affirming** that what you want is happening.
            
            @role attributes help color-code the validation messages:
               * role="error" or "fatal": color is red
               * role="warning" or "warn": color is yellow
               * role="info" or "information": color is blue
            -->
        </rule>
      
      <rule context="container" role="fatal">
          <assert test="descendant::tricky ! string-length(.) lt 10">
              My string-length should be less than 10! I TELL YOU!
          </assert> 
          <!-- The @context is going to control where you see this validation report
              "firing" when the assert test does not pass.
              Probably we should set this context on the <tricky> element to
          make this easier understand in the schema validation process. 
          You want your encoder to be able to find the error easily!
          I set it on <container> deliberately to highlight how the @context attribute
          works to control where the error will appear in the document during validation. 
          -->
      </rule>
        
      <rule context="tricky" role="info">
         <report test="contains(., 'dare')">
             Let me know when you see this word!
         </report>
      
      </rule>
      
  
    </pattern>
    
   
</schema>