<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:cbml="http://www.cbml.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <!-- COLLECTION VARIABLES: Uncomment one of these if you need to process a collection!  -->
    
 <!--   <xsl:variable name="cbml-collection" as="document-node()+" select="collection('cbml/?select=*.xml')"/>-->
    
    <!-- 2023-11-08 ebb: MAKE SURE THERE ARE NO EXTRA SPACES in the collection() variable!   -->
    <!-- Alternative collection variable if your files are nested deeply below where your XSLT is saved: -->
        
   <!-- <xsl:variable name="cbml-nested" as="document-node()+" select="collection('.?select=*.xml;recurse=yes')"/>-->
 
   
    
   <xsl:template match="/">
       <html>
           <head>
               <title>A New CBML Transformation!</title>
               <link rel="stylesheet" type="text/css" href="style.css"/> 
           </head>
           <body>
         
               <h1><xsl:apply-templates select="descendant::titleStmt/title"/></h1> 
               
               
          <div id="table">
              <!-- ebb: Here inside this <div> is where we'll output the linked index or table of contents
              that points into the reading view panels -->
              
              <table>
                  <tr>
                      <th>Page</th>
                      <th>Links to Panels</th>
                  </tr>
                  
                  <xsl:apply-templates select=".//div[@type='page']" mode="toc"/>
                  
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
    <!-- MODAL TEMPLATES FOR TOC HERE -->
   <xsl:template match="div[@type='page']" mode="toc">
       <tr>
           <td>Page <xsl:value-of select="@xml:id ! substring-after(., '_')"/></td> 
           <td>Panels:
               <ul>
                   
                 
                   
               </ul>
          
           </td>
           
       </tr>
      
   </xsl:template> 
    
    <xsl:template match="cbml:panel" mode="toc">
     
    </xsl:template>
    
    
    <!-- READING VIEW TEMPLATES HERE> -->
    <xsl:template match="div[@type='page']">
        <section class="{@type}" id="{@xml:id}">
            <xsl:apply-templates/>

        </section>
    </xsl:template>
    
    <xsl:template match="cbml:panel">
        <div class="panel" id="{parent::div/@xml:id}-panel-{@n}">
            <!-- COME BACK HERE AND GET THE RECIPE FOR LINK TARGETS! -->
            
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