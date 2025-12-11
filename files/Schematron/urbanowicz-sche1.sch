<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
        xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
        queryBinding="xslt2">
    <sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
        
        <title>Banksy Location Validation</title>
        
        <pattern id="geocoding-checks">
            
            <!-- Rule for Australia -->
            <rule context="location[contains(., 'AU')]">
                <assert test="number(@long) > 100">
                    Locations in Australia must have longitude greater than 100 (east of Greenwich).
                </assert>
                <assert test="number(@lat) &lt; 0">
                    Locations in Australia must have negative latitude (south of the equator).
                </assert>
            </rule>
            
            <!-- Rule for USA -->
            <rule context="location[contains(., 'USA')]">
                <assert test="number(@long) &lt; 0">
                    Locations in the USA must have longitude less than 0 (west of Greenwich).
                </assert>
                <assert test="number(@lat) &gt; 0">
                    Locations in the USA must have positive latitude (north of the equator).
                </assert>
            </rule>
            
        </pattern>
        
    </schema>
</sch:schema>