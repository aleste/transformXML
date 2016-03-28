<?php
  
   $xslDoc = new DOMDocument();
   $xslDoc->validateOnParse = true;
   $xslDoc->load("uploads/xsl/test.xsl");

   
   $xmlDoc = new DOMDocument();
   $xmlDoc->load("uploads/xml/test.xml");

   $proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);

   echo $proc->transformToXML($xmlDoc);    

