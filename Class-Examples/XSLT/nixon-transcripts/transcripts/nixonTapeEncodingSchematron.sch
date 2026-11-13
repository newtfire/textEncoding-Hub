<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <pattern>
        <rule context="person">
            <assert test="@xml:id">
                Every person listed MUST have an id.
            </assert>
        </rule>
    </pattern> 
    
    <pattern>
        <rule context="title">
            <assert test="normalize-space(.)">
                Every title must contain text.
            </assert>
        </rule>
    </pattern> 
    
    <pattern>
        <rule context="u">
            <assert test="@who">
                Every spoken utterance must have a who attribute.
            </assert>
        </rule>
    </pattern> 
    
    <pattern>
        <rule context="persName">
            <assert test="@ref">
                Every persName must have a ref attribute. 
            </assert>
        </rule>
    </pattern>
    
</schema> 