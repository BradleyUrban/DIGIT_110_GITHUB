<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="3.0"
    
    xmlns="http://www.w3.org/1999/xhtml"
    
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    
    exclude-result-prefixes="tei cbml">
   
    <xsl:output method="xhtml" html-version="5"
        omit-xml-declaration="yes"
        include-content-type="no"
        indent="yes"/>
    
    <xsl:variable name="comicColl" as="document-node()+"
        select="collection('cbml-spidey/?select=*.xml')"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Spiderman CBML Collection</title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link rel="stylesheet" type="text/css" href="webstyle.css"/>
            </head>
            
            <body>
                
                <h1>Spiderman Comic Reading View</h1>
                
                <section id="toc">
                    <h2>Table of Contents</h2>
                    
                    <table>
                        <tr>
                            <th>Page #</th>
                            <th>Characters Mentioned</th>
                            <th>Preview (first 80 characters)</th>
                        </tr>
                        
                        <xsl:apply-templates 
                            select="$comicColl//cbml:page"
                            mode="toc">
                            <xsl:sort select="@n" data-type="number"/>
                        </xsl:apply-templates>
                    </table>
                </section>
                
                
                <section id="reading-view">
                    <h2>Full Reading View</h2>
                    
                    <xsl:apply-templates 
                        select="$comicColl//cbml:page">
                        <xsl:sort select="@n" data-type="number"/>
                    </xsl:apply-templates>
                </section>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="cbml:page" mode="toc">
        <tr>
            
            <td>
                <xsl:value-of select="@n"/>
            </td>
            
            <td>
                <xsl:value-of 
                    select="
                    string-join(
                    distinct-values(
                    .//cbml:charRef/@ref 
                    => sort()
                    ),
                    ', ')"/>
            </td>
            
            <td>
                <xsl:value-of 
                    select="substring(
                    normalize-space(string-join(.//text(), ' ')),
                    1,
                    80
                    )"/>
                <xsl:text>…</xsl:text>
            </td>
            
        </tr>
    </xsl:template>
    
    <xsl:template match="cbml:page">
        <div class="page" id="page-{@n}">
            <h3>Page <xsl:value-of select="@n"/></h3>
            
            <xsl:apply-templates select="cbml:panel"/>
        </div>
    </xsl:template>
    

    <xsl:template match="cbml:panel">
        <div class="panel" id="{@xml:id}">
            <h4>Panel <xsl:value-of select="@n"/></h4>
            
            <!-- panel contents -->
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="cbml:balloon">
        <div class="balloon balloon-{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="cbml:speaker">
        <span class="speaker"><strong>
                <xsl:apply-templates/>
        </strong></span>
    </xsl:template>
    
    <xsl:template match="cbml:caption">
        <div class="caption">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="cbml:soundEffect">
        <span class="sound-effect">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
 
    <xsl:template match="cbml:charRef">
        <span class="charRef">
            <xsl:value-of select="@ref"/>
        </span>
    </xsl:template>
 
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
