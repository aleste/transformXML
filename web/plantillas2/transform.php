<?php

   $xslDoc = new DOMDocument();
   $xslDoc->load("plantilla.xsl");

   $xmlDoc = new DOMDocument();
   $xmlDoc->load("datos.xml");

   $proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);
   echo $proc->transformToXML($xmlDoc);

?>