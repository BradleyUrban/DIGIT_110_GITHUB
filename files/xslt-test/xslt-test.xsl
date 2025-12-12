<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes"/>
    <!-- **************************************************************************-->
    <!-- 2025-11-21 ebb: This XSLT starter file is for the XSLT test in DIGIT 110. 
    Do not alter the stylesheet root element or the output line. 
    
   Your task is to transform the source XML document of Bram Stoker's novel Dracula into HTML with a 
   table of contents linked to a reading view, and styled with CSS. Your XSLT code needs to 
   * process one source XML file and output one valid and well-formed HTML file;
   * contain an HTML table  for the table of contents featuring:
        * each chapter heading
        * each chapter's distinct sorted people/characters mentioned: <person> 
        * each chapter's distinct sorted technologies mentioned: <tech>
     
   * contain internal links from the chapter headings in the table of contents to the chapter headings;
   * contain span elements in the reading view to stylize the persons and technologies mentioned. 
   * Prepare CSS to style your HTML. The XSLT should output the CSS link line to your CSS file accurately. 
   
   
    -->  
    <!-- **************************************************************************-->
    
    <!-- MAIN TEMPLATE -->
    <xsl:template match="/root">
        <html>
            <head>
                <title><xsl:value-of select="title"/></title>
                <link rel="stylesheet" type="text/css" href="style.css"/>
            </head>
            <body>
                <h1 id="top"><xsl:value-of select="title"/></h1>
                
                <!-- TABLE OF CONTENTS -->
                <section id="contents">
                    <h2>Table of Contents</h2>
                    <table>
                        <tr>
                            <th>Chapter</th>
                            <th>People</th>
                            <th>Tech</th>
                            <th>Locations</th>
                        </tr>
                        <xsl:apply-templates select="chapter" mode="toc"/>
                    </table>
                </section>
                
                <!-- READING VIEW -->
                <section id="readingView">
                    <h2>Reading View</h2>
                    <xsl:apply-templates select="chapter"/>
                </section>
            </body>
        </html>
    </xsl:template>
    
    <!-- TABLE OF CONTENTS MODE -->
    <xsl:template match="chapter" mode="toc">
        <tr>
            <td>
                <a href="#chap-{position()}">
                    <xsl:value-of select="chapTitle"/>
                </a>
            </td>
            
            <!-- PEOPLE -->
            <td>
                <xsl:for-each select="distinct-values(.//person)">
                    <xsl:sort/>
                    <span><xsl:value-of select="."/></span>
                    <xsl:text> </xsl:text>
                </xsl:for-each>
            </td>
            
            <!-- TECH -->
            <td>
                <xsl:for-each select="distinct-values(.//tech)">
                    <xsl:sort/>
                    <span><xsl:value-of select="."/></span>
                    <xsl:text> </xsl:text>
                </xsl:for-each>
            </td>
            
            <!-- LOCATIONS -->
            <td>
                <xsl:for-each select="distinct-values(.//loc)">
                    <xsl:sort/>
                    <span><xsl:value-of select="."/></span>
                    <xsl:text> </xsl:text>
                </xsl:for-each>
            </td>
        </tr>
    </xsl:template>
    
    <!-- READING VIEW: CHAPTER -->
    <xsl:template match="chapter">
        <article id="chap-{position()}">
            <h2><xsl:value-of select="chapTitle"/></h2>
            <xsl:apply-templates/>
        </article>
    </xsl:template>
    
    <!-- PARAGRAPHS -->
    <xsl:template match="p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <!-- INLINE ELEMENTS -->
    <xsl:template match="person">
        <span class="person"><xsl:value-of select="."/></span>
    </xsl:template>
    
    <xsl:template match="tech">
        <span class="tech"><xsl:value-of select="."/></span>
    </xsl:template>
    
    <xsl:template match="loc">
        <span class="loc"><xsl:value-of select="."/></span>
    </xsl:template>
    
    <xsl:template match="date | time | cloth | people">
        <span class="info"><xsl:value-of select="."/></span>
    </xsl:template>
    
    <!-- DEFAULT TEXT -->
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>

