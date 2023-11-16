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
              
              <!-- ************************************************* -->
              <!--  MAKING VARIABLES: PREPARING TO MOVE "OFF THE TREE", AND THEN BACK ON THE TREE AGAIN!  -->
              <!-- ************************************************* -->
              <!-- A. We are going to be stepping "off the tree", and we want to be able to move back on again! 
                  To help with that, first we need a special variable.
                  
                  This special variable needs to store our document tree:
                  whatever XML node we are processing in this template. 
                  (It happens to be the document node here, but you can use this anywhere.) 
                  
                  In XSLT, current() is the current node or item the
             template rule is processing. I'M SUPPLYING THIS VARIABLE HERE. 
              -->
              
              <xsl:variable name="docTree" as="document-node()" select="current()"/>

              <!-- B. Now we create a new variable here to collect the data from distinct-values() that 
                we want to index from our source file! 
                This variable will store information that's pulled OFF the tree! 
           
           * NOTICE: We'll give this variable an @as value of item()+ because it's NOT a node! 
            It is going to store a **data pull** of strings pulled from the tree, 
            so we can't call it a document(), element(), or attribute(). It's just going to be one or more items, or 
            item()+. 
           
            FINISH WRITING THIS VARIABLE HERE. Its @select attribute will reach for an XPath expression and use XPath function(s). 
            (we'll get you started in class / on the homework assignment.)
            -->   

              
              <xsl:variable name="myData" as="item()+" select=".//cbml:panel/@characters ! normalize-space() ! 
                  tokenize(., ' ') => distinct-values() => sort()"/>
            
              <!-- ************************************************* -->
              <!-- USING THE VARIABLES! 
                  We're going to output our indexed linked data in one HTML table. 
                  We "set the table" here so we have two columns (two cells that will output side by side).
                  We set it up with a first "table header row" to lay out what we want to output! 
                  The very first <tr> has the special <th> header cells that label the columns.
              -->
              <!-- ************************************************* -->
              
              
              
              <!-- Okay! Let's add a Character to the table as a first column: -->
 
 
              <table>
                  <tr>
                      <th>Character</th>
                      <th>Links to Panels </th>
              
                  </tr>
                  
                 <xsl:for-each select="$myData"> 
                     
                     <tr>
                        
                         <td><xsl:value-of select="current()"/></td>
                         <td>
                             <ul>
                             <xsl:apply-templates select="$docTree//div[@type='page' and cbml:panel[contains(@characters, current()) ]]" mode="toc">
                               <xsl:with-param name="currentCharacter" as="item()" select="current()"/>  
                             </xsl:apply-templates>
                             <!-- TREE WALKER VARIABLE  -->
                                 
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
    
    <!-- MODAL TEMPLATES FOR TOC HERE! -->
    <xsl:template match="div[@type='page']" mode="toc">
        <xsl:param name="currentCharacter"/>
       
        <li>Page <xsl:value-of select="@xml:id ! substring-after(., '_')"/>
           
           <ul>
           <xsl:apply-templates select="descendant::cbml:panel" mode="toc">
               
               <xsl:with-param name="currentCharacter" select="$currentCharacter"/>
           </xsl:apply-templates>
           </ul>   
       </li>
        

        
    </xsl:template> 
    
    <xsl:template match="cbml:panel" mode="toc">
        <xsl:param name="currentCharacter"/>
        <xsl:if test="@characters ! contains(., $currentCharacter)">
            <li>
            <a href="#{ancestor::div/@xml:id}-panel-{@n}">Panel <xsl:value-of select="@n"/></a>
        </li>
        </xsl:if>
        
    </xsl:template>
    
    
    <!-- READING VIEW TEMPLATES HERE! -->
    
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