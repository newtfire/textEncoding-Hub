<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <!-- COLLECTION VARIABLE: this one is excluding the site index file that's in the same directory. -->
    
    <xsl:variable name="cbml-collection" as="document-node()+" 
        select="collection('xml/?select=*.xml')[base-uri() ! not(contains(., 'cbml-si'))]"/>
    
    <!-- ebb: MAKE SURE THERE ARE NO EXTRA SPACES in the collection() variable!   -->
    
   <xsl:variable name="site-index" as="document-node()" select="doc('xml/cbml-si.xml')"/>
 
   
    
   <xsl:template match="/">
       <html>
           <head>
               <title>Tinkering with Team Fortress CBML Collection and Site Index</title>
               <link rel="stylesheet" type="text/css" href="style.css"/> 
           </head>
           <body>
         
               <h1>Table of Contents</h1>
                   
                 <ol>
                   
                       
            <xsl:apply-templates select="$cbml-collection//titleStmt/title" mode="toc"/>
                
                <!--ebb:  Distinct id for files is based on its filename -->
                                   
                   
                 </ol>
     
        <div id="reading-view">  
            <xsl:for-each select="$cbml-collection">
 
                <xsl:variable name="filename" select="current() ! base-uri() ! tokenize(., '/')[last()] ! 
                    substring-before(., '.xml')"/>
                <xsl:result-document method="xhtml" html-version="5" 
                    omit-xml-declaration="yes" include-content-type="no"
                    indent="yes" href="docs/{$filename}.html">
                    <html>
                        <head><title><xsl:apply-templates 
                                    select="descendant::titleStmt/title"/></title>
                            <link rel="stylesheet" type="text/css" href="style.css"/> 
                        </head>
                        <body>
                            
                            
                            <xsl:apply-templates select="descendant::div"/>
                            
                        </body>
                        
                    </html>
                    

                </xsl:result-document>
            </xsl:for-each>
 
        
             
          
          </div>
   
           </body>
       </html>
   </xsl:template> 
    
    <xsl:template match="titleStmt/title" mode="toc">
        
        <li><a href="{current() ! base-uri(.) ! tokenize(., '/')[last()] ! 
                substring-before(., '.xml')}.html">
                <xsl:apply-templates select="current()"/></a></li>
        
    </xsl:template>
    
    
    
    <xsl:template match="div[@type='page']">
        <section class="{@type}" id="{@xml:id}">
            <xsl:apply-templates/>

        </section>
    </xsl:template>
    
    <xsl:template match="cbml:panel">
        <div class="panel" id="{ancestor::div/@xml:id}-panel-{@n}">
            
         <xsl:apply-templates/>            
            
        </div>
    
    </xsl:template>
    
    <xsl:template match="cbml:caption">
        <p class="cbml-caption">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="note">
        <p class="{@type}">
            <xsl:apply-templates/>
        </p>  
    </xsl:template>
    
    <xsl:template match="sound">
        <span class="{name()}" style="color:red">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    
    <xsl:template match="p | figDesc[not(ancestor::p)]">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="figure[not(parent::p)]">
        <figure class="{@type}">
            <xsl:apply-templates/>
            
        </figure>
  
    </xsl:template>

 
    
 

    
</xsl:stylesheet>