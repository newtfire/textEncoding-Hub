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
               
          <div id="characterTable">
           
              <!-- We're going to need this in the panel lookup! -->
              
              <!-- TBD:  XSLT to find the characters by page or panel here. -->
 
      
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
     
        </section>
    </xsl:template>
    
   
   
   <!--ebb: There are some figure and figDescs coded inisdes p elements in the CBML, 
       so I tred to exclude them here. -->

    
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