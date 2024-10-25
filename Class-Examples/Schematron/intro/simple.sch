<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <pattern>
        <rule context="scene">
            <report test="@type='silent' and child::dialogue">
                If there is a type attribute reading "silent", there must not be a child 
                dialogue element here. Use a  descript element instead!</report>            
        </rule>

    </pattern>
       
    
</schema>