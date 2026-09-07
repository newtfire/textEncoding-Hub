<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <pattern>
        <rule context="blort">
            <report test="count(blob) lt 3">WHYY??? WHY DO YOU THIS EVERY TIME? Every blort element is supposed to contain at least
            three blob elements.</report> 
        </rule>
        
        <rule context="blob">
            <assert test="contains(., 'hi')">Oh no! The blob doesn't say "hi"! :-( </assert>
            
        </rule>
        
    </pattern>
 
    
</schema>