<?xml version="1.0" encoding="UTF-8"?>

<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2">
    
    <sch:title>Behrend Calendar Validation</sch:title>
    
    <sch:ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    
    <sch:pattern id="calendar-dates">
        <sch:rule context="tei:date[@when]">
            <sch:assert test="matches(@when, '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')">
                Dates with a when attribute should use YYYY-MM-DD format.
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
</sch:schema>
