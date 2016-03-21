<?php
  
   $xslDoc = new DOMDocument();
   $xslDoc->validateOnParse = true;
   $xslDoc->load("uploads/xsl/plantilla.xsl");

   
   $xmlDoc = new DOMDocument();
   $xmlDoc->load("uploads/xml/datos.xml");

   $proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);

   echo $proc->transformToXML($xmlDoc);    

