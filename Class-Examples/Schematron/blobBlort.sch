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
        
      <rule context="tricky" role="info">
         <report test="contains(., 'dare')">
             Let me know when you see this word, "dare"!
         </report>
      <!--The text content of your <report> or <assert> elements becomes
          your customized error message on a validation check! Don't forget to write
      your validation message! Good messages usually explain simply in human-readable terms 
      what the XPath in the @test is checking for. -->
      </rule>
      
      <rule context="container" role="fatal">
          <assert test="descendant::* ! string-length() &lt; 10">
              The string-lengths of each of my descendant elements should be less than 10! I TELL YOU!
              But now I made it so YOU have to find which node is at fault, because I've decided to 
              make your life difficult!
          </assert> 
          <!-- ebb: I made this one deliberately challenging, 
              to help show a couple of things about Schematron.
              
           The @context is going to control where you see this validation report
              "firing" when the assert test does not pass.
              Probably we should rewrite this to set this context on the <tricky> or <blob> element to
          make this easier understand in the schema validation process. 
          You want your encoder to be able to find the error easily!
          
          I set the rule's @context on <container> deliberately to highlight how the @context attribute
          works to control where the error will appear in the document during validation.
          
           I also want to demonstrate how we use the **value comparison** operators like
           &lt; (for < ) or &gt; (for >) when we're testing
          **multiple nodes on the left** against a single number on the right:
          
          //container//* is multiple elements. String-length() returns multiple numbers, 
          a string-length() measurement for each child node: 2, 12, 2, 36 in our blortBlob.xml
   
         The value comparison operator lets you know whether ANY in that list of results will 
         violate the rule that the string-length() must be less than 10, 
         and if it does (as in two cases here), the test will be affirmed or the condition will be violated
         and assert will fire its validation message. 
          -->
      </rule>
      
  
    </pattern>
    
   
</schema>