<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">

    <pattern>
        <rule context="location[contains(., 'AU') ]">
          
            <assert test="@long &gt;= 100">
                Australia locations MUST have a longitude greater than or equal to 100.</assert>
            
            
            <!-- either <assert> or <report> 
           
           An <assert test="..."> will check to make sure that the conditions in the @test are ture. 
           Use this when defining the conditions for "ALL'S WELL". It will fire when the conditions described are violated.
           
           A <report test="..."> will SHOUT OUT if the conditions described are TRUE! Think of this as a "Red Alert"! 
           
           In AU: 
           * longitude is far to the east of the Prime Meridean: values higher than 100
           * latitude must be a negative number, less than zero
           
           
           -->
        </rule>
     
    </pattern>
</schema>
