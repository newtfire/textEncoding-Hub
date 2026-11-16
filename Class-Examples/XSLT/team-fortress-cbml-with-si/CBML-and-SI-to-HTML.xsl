<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <!-- COLLECTION VARIABLE -->
    
    <xsl:variable name="cbml-collection" as="document-node()+" select="collection('xml/?select=*.xml')[base-uri() ! not(contains(., 'cbml-si'))]"/>
    
    <!-- ebb: MAKE SURE THERE ARE NO EXTRA SPACES in the collection() variable!   -->
    
   <xsl:variable name="site-index" as="document-node()" select="doc('xml/cbml-si.xml')"/>
 
   
    
   <xsl:template match="/">
       <html>
           <head>
               <title>Tinkering with Team Fortress CBML Collection and Site Index</title>
               <link rel="stylesheet" type="text/css" href="style.css"/> 
           </head>
           <body>
         
               <h1><xsl:apply-templates select="$cbml-collection//titleStmt/title"/></h1> 
               
          <div id="characterTable">
              <xsl:variable name="characters" as="item()+" 
                  select="descendant::cbml:panel/@characters ! normalize-space() !
                  tokenize(., ' ') ! substring-after(., '#') => distinct-values() => sort()"/>
              
              <xsl:variable name="docTree" as="document-node()" select="current()"/>
              <!-- We're going to need this in the panel lookup! -->
              
              <!-- XSLT to find the characters by panel here. -->
              <table>
                  <tr>
                      <th>character</th>
                      <th>panels</th>
                  </tr>
                  <xsl:for-each select="$characters[string-length() gt 1]">
                      <!-- This excludes an empty match from the Sonic source file. -->
                      <tr>
                          <td>
                              <xsl:value-of select="current() "/>
                          </td>
                          <td>
                              <!-- Here let's output a  linked list of panels in which this
                              character appears!-->
                              <!-- VARIABLE TO LOOK UP THE PAGES THAT SHOW THIS CHARACTER on the source XML tree! -->
                             <xsl:variable name="panelsLookUp" as="element()+" 
                                  select="$docTree//div[@type='page']/cbml:panel[@characters ! contains(., current())]"/>
          
                              <ul>
                                  <xsl:for-each select="$panelsLookUp">
                                      <xsl:sort select="@xml:id"/>
                                      <li><a href="#{parent::div/@xml:id}-panel-{@n}">Page <xsl:value-of select="current()/parent::div/@xml:id ! substring-after(., '_')"/>, panel <xsl:value-of select="@n"/></a></li>
                                      
                                  </xsl:for-each>
         
                              </ul>
                              
                          </td>
                          
                      </tr>
         
                  </xsl:for-each>
                  
              </table>
      
          </div>     

 
               
          <div id="reading-view">        
            <!-- READING VIEW HERE -->
            <xsl:apply-templates select="descendant::body"/>
              
              <!--  IF PROCESSING A COLLECTION of XML files, uncomment this / adapt as needed:
              <xsl:apply-templates select="$cbml-collection//div"/>
          -->
          
          </div>
   
           </body>
       </html>
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