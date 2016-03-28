<?xml version="1.0" encoding="utf-8"?>

  <xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">


  <!-- template principal -->
  <xsl:template match="titulo">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <!-- contiene los layouts para las páginas del documento -->
      <fo:layout-master-set>
        <!-- layout horizontal -->
        <fo:simple-page-master master-name="landscape" page-height="21cm" page-width="29.7cm"  margin-top="1cm"  margin-bottom="2cm"  margin-left="1.5cm"  margin-right="1.5cm" >
          <!-- el body tiene como fondo la imagen del texto COPIA -->
          <fo:region-body />
          <fo:region-before precedence="true" extent="3cm"/>
          <fo:region-after precedence="true" extent="1.5cm"/>
          <fo:region-start extent="1cm"/>
          <fo:region-end extent="1cm"/>
        </fo:simple-page-master>
        <fo:simple-page-master master-name="landscape-no-wm" page-height="21cm" page-width="29.7cm"  margin-top="1cm"  margin-bottom="2cm"  margin-left="1.5cm"  margin-right="1.5cm" >
          <fo:region-body
            background-position="center"
            background-repeat="no-repeat"
            margin-top="0.5cm" margin-bottom="1cm"  margin-left="0.1cm" margin-right="0.1cm" />
          <fo:region-before precedence="true" extent="3cm"/>
          <fo:region-after precedence="true" extent="1.5cm"/>
          <fo:region-start extent="1cm"/>
          <fo:region-end extent="1cm"/>
        </fo:simple-page-master>
        <!-- layout vertical -->
        <fo:simple-page-master master-name="portrait"  page-height="29.7"  page-width="21"  margin-top="1cm"  margin-bottom="2cm"  margin-left="1.5cm"  margin-right="1.5cm"  >
          <fo:region-body />
          <fo:region-before precedence="true" extent="3cm"/>
          <fo:region-after precedence="true" extent="1.5cm"/>
          <fo:region-start extent="1cm"/>
          <fo:region-end extent="1cm"/>
        </fo:simple-page-master>

        <fo:simple-page-master master-name="main1" page-height="29.7"  page-width="21"  margin-top="1cm"  margin-bottom="2cm"  margin-left="1.5cm"  margin-right="1.5cm"  >
          <fo:region-body region-name="caduco" />                    
        </fo:simple-page-master>

        <fo:simple-page-master master-name="A4-portrait" page-height="29.7cm" page-width="21cm" margin-top="1cm"  margin-bottom="2cm"  margin-left="1.5cm"  margin-right="1.5cm">
          <fo:region-body margin-top="1.5cm" margin-bottom="1cm"  margin-left="1cm" margin-right="3cm"/>
          <fo:region-before precedence="true" extent="2cm"/>
      </fo:simple-page-master>

        <fo:simple-page-master master-name="A4-landscape" page-height="21cm" page-width="29.7cm">
    <fo:region-body/>
  </fo:simple-page-master>



    <fo:page-sequence-master master-name="DP1">
      <fo:repeatable-page-master-reference master-reference="main1" />
    </fo:page-sequence-master>


      </fo:layout-master-set>

      <!-- secuencia de páginas principal (horizontal)-->
      <fo:page-sequence master-reference="landscape" initial-page-number="1">
        <fo:flow  font-family="monospace" flow-name="xsl-region-body">
          <fo:block>
            <!-- usamos tablas de la misma manera que se usaban en su momento en HTML, para poder alinear y presentar la información.
            Es posible utilizar un sistema similar al float de css con fo:float, pero la libreria que utilizamos para renderizar el PDF no lo permite en la versión actual.
            -->
            <fo:table width="27cm" text-align="center" font-size="9.5pt" border-collapse="separate" border-separation="5pt">
                <!--

                Es necesario definir la cantidad de columnas que tiene una tabla  colocando un elemento fo:table-column por cada una.

                En este caso, usamos 18 columnas
                -->
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-column />
                <fo:table-body>
                  <!--

                  Se pueden usar dos formas para 'llamar' a un template en XSL

                  xsl:call-template es un equivalente cercano a llamar a una función en un lenguaje de programación. El template se define con un nombre (datos-titulo) y cuando se llama simplemente se 'ejecuta' con el contexto actual y los parámetros pasados (para ver un ejemplo de usos de parámetros ver planes_caducos.xslt).

                  xsl:apply-templates toma cualquier número de nodos xml (definidos en el select) e itera sobre ellos aplicando los templates que correspondan.

                  En este caso, ambos son equivalentes ya que el call-template no utiliza parámetros y el apply-templates sólo selecciona un elemento.

                  Para más información acerca de la distinción ver: http://stackoverflow.com/questions/4478045/what-are-the-difference-between-call-template-and-apply-templates-in-xsl

                  -->
                  <xsl:call-template name="datos-titulo" />
                  <xsl:apply-templates select="personas/persona[es_titular= 'T']"></xsl:apply-templates>
                </fo:table-body>
              </fo:table>
            </fo:block>
          <!-- linea divisoria -->
          <fo:block
              space-before.optimum="5pt"
              space-after.optimum="5pt"
              border-top-style="dashed">
          </fo:block>

          <!-- tabla de deudas -->
          <xsl:call-template name="deudas" />
        

        </fo:flow>
      </fo:page-sequence>

      <!-- si existen co-deudores, llamamos al template (otra page-secuence) -->
      <xsl:if test="//personas/persona[es_titular='A']">
        <xsl:call-template name="codeudores" />
      </xsl:if>
      <!-- si existen planes caducos, llamamos al template (page-secuence horizontal)-->
      <xsl:if test="plan_caduco/deudas_plan_caduco/deuda_plan_caduco">
        <xsl:call-template name="planes" />
      </xsl:if>
    
        <xsl:if test="//titulo/QrCodeData">
            <xsl:call-template name="qr-codes" />
        </xsl:if>
    </fo:root>
  </xsl:template>

  <!--
    Agregamos un template vacio que corresponda a todo el texto para que cualquier dato que *no* este incluido  en los distintos templates *no* se muestre
  -->
  <xsl:template match="text()"/>
  
  
  
  
  <xsl:template name="domicilio-cell">
  <xsl:param name="value" />

  <fo:table-cell
    padding="4pt"
    border="0.6pt solid black"
    >
      <fo:block> <xsl:value-of select="$value" /> </fo:block>
   </fo:table-cell>
</xsl:template>

<xsl:template name="domicilios">
  <fo:table  width="26cm">
    <fo:table-column />
    <fo:table-column />
    <fo:table-column />
    <fo:table-column />
    <fo:table-header>
      <fo:table-row >
        <fo:table-cell padding="6pt" border="0.6pt solid black" number-columns-spanned="4" font-weight="bold" background-color="#f5f5f5">
          <fo:block>Domicilios</fo:block>
        </fo:table-cell>
      </fo:table-row>
    </fo:table-header>

    <fo:table-body>
      <xsl:for-each select="domicilios/domicilio">

        <fo:table-row keep-with-previous="always">
          <xsl:call-template name="domicilio-cell">
            <xsl:with-param name="value">
              <fo:block>
                Calle: <xsl:value-of select="calle"/>
              </fo:block>
            </xsl:with-param>
          </xsl:call-template>

          <xsl:call-template name="domicilio-cell">
            <xsl:with-param name="value">
              <fo:block>
                Número: <xsl:value-of select="nro"/>
              </fo:block>
            </xsl:with-param>
          </xsl:call-template>

          <xsl:call-template name="domicilio-cell">
            <xsl:with-param name="value">
              <fo:block>
                Piso: <xsl:value-of select="piso"/>
              </fo:block>
            </xsl:with-param>
          </xsl:call-template>

          <xsl:call-template name="domicilio-cell">
            <xsl:with-param name="value">
              <fo:block>
                Depto: <xsl:value-of select="depto"/>
              </fo:block>
            </xsl:with-param>
          </xsl:call-template>
        </fo:table-row>

        <fo:table-row keep-with-previous="always" >

          <xsl:call-template name="domicilio-cell">
            <xsl:with-param name="value">
              <fo:block>
                Localidad: <xsl:value-of select="localidad"/>
              </fo:block>
            </xsl:with-param>
          </xsl:call-template>

          <xsl:call-template name="domicilio-cell">
            <xsl:with-param name="value">
              <fo:block>
                cod. post: <xsl:value-of select="codigo_postal"/>
              </fo:block>
            </xsl:with-param>
          </xsl:call-template>

          <xsl:call-template name="domicilio-cell">
            <xsl:with-param name="value">
              <fo:block>
                Anexo: <xsl:value-of select="nro_complemento"/>
              </fo:block>
            </xsl:with-param>
          </xsl:call-template>

          <fo:table-cell border="0.6pt solid black">
            <fo:block></fo:block>
          </fo:table-cell>

        </fo:table-row>
      </xsl:for-each>
    </fo:table-body>
  </fo:table>
</xsl:template>

<xsl:template name="datos-codeudor">
  <fo:table  width="26cm"  border-collapse="separate" border-separation="5pt">
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />

      <fo:table-body text-align="center">
	  
		<fo:table-row keep-together.within-page="always">

			<fo:table-cell background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="3">
				<fo:block>
				  <fo:block font-weight="bold">IMPUESTO</fo:block>
				  <xsl:call-template name="impuesto_desc">
					<xsl:with-param name="codimpuesto">
						  <xsl:value-of select="//codigo_impuesto"/>
					</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</fo:table-cell>

			
			<fo:table-cell background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="6">
				<fo:block>
				  <fo:block font-weight="bold">EXPEDIENTE</fo:block>
				  <xsl:value-of select="//nro_expediente" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="3">
				<fo:block>
				  <fo:block font-weight="bold">TITULO</fo:block>
				  <xsl:value-of select="//nro_titulo" />
				</fo:block>
			</fo:table-cell>
			

		</fo:table-row>

	  
	  
        <fo:table-row keep-together.within-page="always">
          <fo:table-cell font-size="12pt" background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="5">
            <fo:block>
              <fo:block font-weight="bold">APELLIDO Y NOMBRE</fo:block>
              <xsl:value-of select="apellido"/>
              <xsl:if test="nombre != ''">
                ,
                <xsl:value-of select="nombre"/>
              </xsl:if>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell background-color="#f5f5f5" border="0.5pt solid black" number-columns-spanned="3">
            <fo:block>
              <fo:block font-weight="bold">TIPO Y N° DOCUMENTO</fo:block>
              <xsl:choose>
                <xsl:when test="tipo_documento = 1">
                  CI
                </xsl:when>
                <xsl:when test="tipo_documento = 2">
                  CF
                </xsl:when>
                <xsl:when test="tipo_documento = 3">
                  LE
                </xsl:when>
                <xsl:when test="tipo_documento = 4">
                  LC
                </xsl:when>
                <xsl:when test="tipo_documento = 5">
                  PAS
                </xsl:when>
                <xsl:when test="tipo_documento = 6">
                  DNI
                </xsl:when>
                <xsl:when test="tipo_documento = 7">
                  IPJ
                </xsl:when>
                <xsl:when test="tipo_documento = 8">
                  DNIE
                </xsl:when>
                <xsl:when test="tipo_persona = 'J'">
                  <xsl:value-of select="tipo_personeria_juridica" />
                </xsl:when>
              </xsl:choose>
               &#x00A0;
              <xsl:choose>
                <xsl:when test="tipo_persona = 'J'">
                  <xsl:value-of select="nro_personeria_juridica"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="nro_documento"/>
                </xsl:otherwise>
              </xsl:choose>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell background-color="#f5f5f5" border="0.5pt solid black" number-columns-spanned="2">
            <fo:block>
              <fo:block font-weight="bold">CUIT</fo:block>
              <xsl:value-of select="cuit"/>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell  background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="2">
            <fo:block>
              <fo:block font-weight="bold">NACIONALIDAD</fo:block>
              <xsl:value-of select="nacionalidad"/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
		
		<fo:table-row keep-together.within-page="always">

			<fo:table-cell background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="3">
				<fo:block>
				  <fo:block font-weight="bold">PERSONA</fo:block>
				  <xsl:value-of select="tipo_persona"/>
				</fo:block>
			</fo:table-cell>

			
			<fo:table-cell background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="2">
				<fo:block>
				  <fo:block font-weight="bold">SEXO</fo:block>
				  <xsl:value-of select="sexo"/>
				</fo:block>
			</fo:table-cell>

			<fo:table-cell background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="5">
				<fo:block>
				  <fo:block font-weight="bold">PERSONA JURIDICA</fo:block>
				  <fo:block>TIPO: <xsl:value-of select="tipo_personeria_juridica"/> NRO: <xsl:value-of select="nro_personeria_juridica"/></fo:block>
				  
				</fo:block>
			</fo:table-cell>

			<fo:table-cell background-color="#f5f5f5"  border="0.5pt solid black" number-columns-spanned="2">
				<fo:block>
				  <fo:block font-weight="bold">DELEGACION</fo:block>
				  <xsl:value-of select="//codigo_delegacion" />
				</fo:block>
			</fo:table-cell>
			

		</fo:table-row>

		
      </fo:table-body>
    </fo:table>
</xsl:template>

<xsl:template name="codeudores">

  <fo:page-sequence master-reference="landscape">

    <fo:static-content flow-name="xsl-region-before">
      <fo:block padding="4pt" text-align="end" font-size="10pt" line-height="14pt" >
        Anexo - Codeudores
      </fo:block>
    </fo:static-content>

    <fo:flow font-size="10pt" font-family="monospace" flow-name="xsl-region-body">
      <fo:block space-before="15pt">
        <xsl:for-each select="//persona[es_titular='A']">
          <fo:table keep-together.within-page="always">
            <fo:table-column />
            <fo:table-body>
              <fo:table-row>
                <fo:table-cell padding="6pt">
                  <xsl:call-template name="datos-codeudor" />
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row keep-with-previous="always">
                <fo:table-cell>
                  <xsl:call-template name="domicilios" />
                </fo:table-cell>
              </fo:table-row>
            </fo:table-body>
          </fo:table>




          <!-- linea divisoria -->
          <fo:block space-before.optimum="10pt" space-after.optimum="20pt" border-top-style="solid" />

        </xsl:for-each>
      </fo:block>
    </fo:flow>
  </fo:page-sequence>

</xsl:template>

<xsl:template match="personas/persona[es_titular = 'T']" name="titular">
    <fo:table-row>
      <fo:table-cell number-columns-spanned="8">
        <fo:block  border="0.5pt solid black">
          <fo:block border-bottom="0.5pt solid black" font-weight="bold">APELLIDO Y NOMBRES / RAZÓN SOCIAL</fo:block>
          <xsl:value-of select="apellido"/>
            <xsl:if test="nombre != ''">
              ,
              <xsl:value-of select="nombre"/>
            </xsl:if>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell number-columns-spanned="4">
        <fo:block  border="0.5pt solid black">
          <fo:block font-weight="bold" border-bottom="0.5pt solid black">TIPO Y N° DE DOCUMENTO</fo:block>
          <fo:block>
            <xsl:choose>
              <xsl:when test="tipo_documento = 1">
                  CI
                </xsl:when>
              <xsl:when test="tipo_documento = 2">
                  CF
                </xsl:when>
              <xsl:when test="tipo_documento = 3">
                  LE
                </xsl:when>
              <xsl:when test="tipo_documento = 4">
                  LC
                </xsl:when>
              <xsl:when test="tipo_documento = 5">
                  PAS
                </xsl:when>
              <xsl:when test="tipo_documento = 6">
                  DNI
                </xsl:when>
              <xsl:when test="tipo_documento = 7">
                  IPJ
                </xsl:when>
              <xsl:when test="tipo_documento = 8">
                  DNIE
                </xsl:when>
              <xsl:when test="tipo_persona = 'J'">
                <xsl:value-of select="tipo_personeria_juridica" />
              </xsl:when>
            </xsl:choose>
            &#x00A0;
            <xsl:choose>
              <xsl:when test="tipo_persona = 'J'">
                <xsl:value-of select="nro_personeria_juridica"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="nro_documento"/>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block></fo:block>
        </fo:table-cell>
        <fo:table-cell number-columns-spanned="3">
          <fo:block  border="0.5pt solid black">
            <fo:block font-weight="bold" border-bottom="0.5pt solid black">CUIT TITULAR</fo:block>
            <xsl:value-of select="cuit"/>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell number-columns-spanned="3">
          <fo:block  border="0.5pt solid black">
            <fo:block font-weight="bold" border-bottom="0.5pt solid black">NACIONALIDAD</fo:block>
            <xsl:choose>
              <xsl:when test="nacionalidad != ''">
                <xsl:value-of select="nacionalidad"/>
              </xsl:when>
              <xsl:otherwise>
                -
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
      <fo:table-row>
        <fo:table-cell number-columns-spanned="9">
          <fo:block  border="0.5pt solid black">
            <fo:block font-weight="bold" border-bottom="0.5pt solid black">DOMICILIO FISCAL</fo:block>
            <xsl:value-of select="//domicilioFiscal/calle"/>
            <xsl:if test="//domicilioFiscal/nro != 0">
            &#x00A0;
            <xsl:value-of select="//domicilioFiscal/nro" />
            </xsl:if>
            <xsl:if test="//domicilioFiscal/piso != ''">
              &#x00A0;
              <xsl:value-of select="//domicilioFiscal/piso"/>° <xsl:value-of select="//domicilioFiscal/depto"/>
            </xsl:if>
            &#x00A0;
            <xsl:value-of select="//domicilioFiscal/localidad"/>
            -
            <xsl:value-of select="//domicilioFiscal/provincia"/>
            -
            <xsl:value-of select="//domicilioFiscal/codigo_postal"/>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell number-columns-spanned="9">
          <fo:block  border="0.5pt solid black">
            <fo:block font-weight="bold" border-bottom="0.5pt solid black">DOMICILIO PARTICULAR</fo:block>
            <xsl:value-of select="domicilios/domicilio/calle"/> 
            &#x00A0;
            <xsl:value-of select="domicilios/domicilio/nro" />
            <xsl:if test="domicilios/domicilio/piso != ''">
              &#x00A0;
              <xsl:value-of select="domicilios/domicilio/piso"/>° <xsl:value-of select="domicilios/domicilio/depto"/>
            </xsl:if>
            &#x00A0;
            <xsl:value-of select="domicilios/domicilio/localidad"/>
            -
            <xsl:value-of select="domicilios/domicilio/provincia"/>
            -
            <xsl:value-of select="domicilios/domicilio/codigo_postal"/>
          </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </xsl:template>

	  
	  
	      <xsl:template name="planes">
      <xsl:call-template name="selects">
        <xsl:with-param name="i">0</xsl:with-param>

        <xsl:with-param name="count">
          <xsl:choose>
            <xsl:when test="(plan_caduco/deudas_plan_caduco/cantidad_deudas) &gt; (plan_caduco/pagos_plan_caduco/cantidad_pagos)">
              <xsl:value-of select="ceiling((plan_caduco/deudas_plan_caduco/cantidad_deudas) div 10)-1" />
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="ceiling((plan_caduco/pagos_plan_caduco/cantidad_pagos) div 10)-1" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
        <xsl:with-param name="step">10</xsl:with-param>
      </xsl:call-template>
    </xsl:template>

    <xsl:template name="selects">
        <xsl:param name="i" />
        <xsl:param name="count" />
        <xsl:param name="step" />

        <xsl:if test="$i &lt;= $count">
          <xsl:call-template name="planes_int">
            <xsl:with-param name="start">
              <xsl:value-of select="$i*$step" />
            </xsl:with-param>
            <xsl:with-param name="step">
              <xsl:value-of select="$step" />
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>

        <!--begin_: RepeatTheLoopUntilFinished-->
        <xsl:if test="$i &lt;= $count">
            <xsl:call-template name="selects">
                <xsl:with-param name="i">
                    <xsl:value-of select="$i + 1"/>
                </xsl:with-param>
                <xsl:with-param name="count">
                    <xsl:value-of select="$count"/>
                </xsl:with-param>
                <xsl:with-param name="step">
                  <xsl:value-of select="$step" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

<fo:block break-after="page"/>

 <xsl:template match="planes_caducos" name="planes_int">

    <xsl:param name="start" />
    <xsl:param name="end" />
    <xsl:param name="step" />

    <fo:page-sequence master-reference="A4-portrait">

      <fo:static-content flow-name="xsl-region-before">
        <fo:block padding="4pt" text-align="end" font-size="10pt" line-height="14pt" >
          Anexo - Planes Caducos
        </fo:block>
      </fo:static-content>

        <fo:flow font-family="monospace" flow-name="xsl-region-body">
          <fo:table width="18cm">
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />

            <fo:table-body>
              <fo:table-row>
                <fo:table-cell number-columns-spanned="10" padding="5pt"></fo:table-cell>
              </fo:table-row>
              <fo:table-row font-size="11pt" text-align="center">
                <fo:table-cell number-columns-spanned="1" number-rows-spanned="2">
                  <fo:block>                  
                  </fo:block>
                </fo:table-cell>                

                <fo:table-cell number-columns-spanned="4" number-rows-spanned="2">
                  <fo:block  border="1pt solid black" font-weight="bold">
                    <fo:block>R-129</fo:block>
                    TITULO EJECUTIVO
                  </fo:block>
                </fo:table-cell>

                <fo:table-cell number-columns-spanned="1"></fo:table-cell>

                <fo:table-cell
                  padding="6pt"
                  border="0.6pt solid black"
                  number-columns-spanned="3">
                  <fo:block text-decoration="underline" font-weight="bold">
                    ANEXO I
                  </fo:block>
                </fo:table-cell>

                <fo:table-cell number-columns-spanned="1"></fo:table-cell>

                <fo:table-cell padding="6pt" border="0.6pt solid black"   number-columns-spanned="2">
                  <fo:block space-after="4pt" text-decoration="underline" font-weight="bold">
                    TITULO
                  </fo:block>
                  <fo:block><xsl:value-of select="//nro_titulo" /></fo:block>
                </fo:table-cell>

                <fo:table-cell number-columns-spanned="3"></fo:table-cell>

                <fo:table-cell  border="0.6pt solid black"  number-columns-spanned="2">
                  <fo:block font-weight="bold">
                    1 de 1
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell number-columns-spanned="10" padding="5pt"></fo:table-cell>
              </fo:table-row>
            </fo:table-body>

          </fo:table>

        <xsl:if test="plan_caduco/deudas_plan_caduco/deuda_plan_caduco[position() &gt; 1*$start]">
          <fo:table  width="17cm"  >
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-body>
              <fo:table-row font-size="9pt">
                <fo:table-cell
                  padding="3pt"
                  border-top="0.6pt solid black"
                  border-left="0.6pt solid black"
                  number-columns-spanned="4">
                  <fo:block >
                    Detalle de liquidación plan de pago
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="3pt"
                  border-top="0.6pt solid black" number-columns-spanned="2">
                  <fo:block>
                    Ley 12.914 CAP. I.4
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="3pt"
                  border-top="0.6pt solid black" border-right="0.6pt solid black" number-columns-spanned="1">
                  <fo:block>
                    AL <xsl:value-of select="//fecha_liquidacion" />
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row font-size="10pt" text-align="center">
                <fo:table-cell
                  padding="3pt"
                  font-weight="bold" border="0.6pt solid black" number-columns-spanned="7">
                  <fo:block>
                    VALOR A COMPUTAR POR LOS PERIDOS INCLUIDOS EN EL PLAN DE PAGOS(*)
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row
                text-align="center"
                font-weight="bold" font-size="8pt">
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Plan anterior reformulado
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Período original incluido en el plan
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Deuda Original (A)
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Vencimiento Original
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Coeficiente de Liquidación (B)
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Monto Interés (C=D-A)
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Monto Actualizado (D=AXB)$
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>


               <xsl:for-each select="plan_caduco/deudas_plan_caduco/deuda_plan_caduco[position() &gt; 1*$start and position() &lt;= $start+$step]">
                    <fo:table-row font-size="8pt">
                      <fo:table-cell padding="3pt"
                        border-right-width="0.5pt" border-right-style="solid" border-right-color="black"
                        border-left-width="0.5pt" border-left-style="solid" border-left-color="black">
                        <fo:block> <xsl:value-of select="descripcion_plan_incluido" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                        <fo:block> <xsl:value-of select="periodo_deuda" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="importe_deuda" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="fecha_vencimiento" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="indice_actualizacion" /> </fo:block>
                       </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="importe_intereses" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="importe_total_periodo" /> </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                  </xsl:for-each>
                  <fo:table-row>
                    <fo:table-cell padding="4pt" border-width="0.5pt" border-style="solid" number-columns-spanned="6">
                      <fo:block font-size="9pt" font-weight="bold">
                        Valor al <xsl:value-of select="//fecha_liquidacion" /> DE LOS PERIODOS ORIGINALES INCLUIDOS EN EL PLAN
                      </fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right" padding="4pt" border-width="0.5pt" border-style="solid">
                      <xsl:if test="plan_caduco/deudas_plan_caduco/cantidad_deudas &lt;= $start+$step">
                        <fo:block>
                          $<xsl:value-of
                            select="
                            format-number(
                              sum(plan_caduco/deudas_plan_caduco/deuda_plan_caduco/importe_total_periodo)
                              ,'0.##')">
                          </xsl:value-of>
                        </fo:block>
                      </xsl:if>
                    </fo:table-cell>
                  </fo:table-row>
            </fo:table-body>
          </fo:table>
        </xsl:if>

        <xsl:if test="plan_caduco/pagos_plan_caduco/pago_plan_caduco[position() &gt; 1*$start]">
          <!-- PAGOS-->
          <fo:table space-before="20pt"  width="17cm"  >
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />
            <fo:table-column />

            <fo:table-body>
              <fo:table-row font-size="10pt" text-align="center">
                <fo:table-cell
                  padding="3pt"
                  font-weight="bold" border="0.6pt solid black" number-columns-spanned="6">
                  <fo:block>
                    VALOR A COMPUTAR POR LAS CUOTAS PAGAS(**)
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
              <fo:table-row
                text-align="center"
                font-weight="bold" font-size="8pt">
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Plan anterior pago
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Fecha de Pago
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Importe Cuata Plan Abonado (A)
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Coeficiente de Liquidación (B)
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>
                    Pago Actualizado $(C=AxB)
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell
                  padding="2pt"
                  border="0.6pt solid black">
                  <fo:block>

                  </fo:block>
                </fo:table-cell>
              </fo:table-row>

               <xsl:for-each select="plan_caduco/pagos_plan_caduco/pago_plan_caduco[position() &gt; 1*$start and position() &lt;= $start+$step]">
                    <fo:table-row font-size="8pt">
                      <fo:table-cell padding="3pt"
                        border-right-width="0.5pt" border-right-style="solid" border-right-color="black"
                        border-left-width="0.5pt" border-left-style="solid" border-left-color="black">
                        <fo:block> <xsl:value-of select="descripcion_plan_pago" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                        <fo:block> <xsl:value-of select="fecha_pago" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="importe_cuota_plan_abonado" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="coeficiente_liquidacion_cuota" /> </fo:block>
                      </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="importe_pagado_actualizado" /> </fo:block>
                       </fo:table-cell>
                      <fo:table-cell padding="3pt" border-right-width="0.5pt" border-right-style="solid" border-right-color="black">
                          <fo:block> <xsl:value-of select="importe_intereses" /> </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                  </xsl:for-each>
                  <fo:table-row>
                    <fo:table-cell border-right="0.5pt solid" border-left="0.5pt solid" ></fo:table-cell>
                    <fo:table-cell border-right="0.5pt solid"></fo:table-cell>
                    <fo:table-cell border-right="0.5pt solid"></fo:table-cell>
                    <fo:table-cell border-right="0.5pt solid"></fo:table-cell>
                    <fo:table-cell border-right="0.5pt solid"></fo:table-cell>
                    <fo:table-cell padding="4pt 2pt" text-align="center" font-size="7pt" border-right="0.5pt solid" border-top="0.5pt solid">
                      <fo:block>MONTO de caducidad</fo:block>
                      <fo:block>3 = 1 - 2</fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                  <fo:table-row>
                    <fo:table-cell padding="2pt" border-width="0.5pt" border-style="solid" number-columns-spanned="5">
                      <fo:block font-size="9pt" font-weight="bold">
                        Valor al <xsl:value-of select="//fecha_liquidacion" /> DE LOS PERIODOS ORIGINALES INCLUIDOS EN EL PLAN
                      </fo:block>
                    </fo:table-cell>
                    <fo:table-cell text-align="right" border-width="0.5pt" border-style="solid">

                       <xsl:if test="plan_caduco/pagos_plan_caduco/cantidad_pagos &lt;= $start+$step">
                        <fo:block>
                          $<xsl:value-of
                            select="
                            format-number(
                              sum(plan_caduco/pagos_plan_caduco/pago_plan_caduco/importe_pagado_actualizado)
                              ,'0.##')">
                          </xsl:value-of>
                        </fo:block>
                      </xsl:if>
                    </fo:table-cell>
                  </fo:table-row>
            </fo:table-body>
          </fo:table>
        </xsl:if>
        </fo:flow>
    </fo:page-sequence>
</xsl:template>



  <xsl:decimal-format name="euroFormat" decimal-separator="," grouping-separator="."/>

  <!--

  Elementos usados en el template

  -->

  <!-- formato de numeros -->
  <xsl:template name="number-format">
    <xsl:param name="number" />
    <xsl:value-of select="format-number($number, '###.###,000', 'euroFormat')"/>
  </xsl:template>

  <xsl:template name="number-format_2_decimales">
    <xsl:param name="number" />
    <xsl:value-of select="format-number($number, '###.###,00', 'euroFormat')"/>
  </xsl:template>

  <!-- template para obtener el impuesto en base al codigo -->
  <xsl:template name="impuesto_desc">
    <xsl:param name="codimpuesto" />
		<xsl:choose>
		  <xsl:when test="$codimpuesto = 131">
			Inmobiliario
		  </xsl:when>
		  <xsl:when test="$codimpuesto = 211">
			Ingresos Brutos
		  </xsl:when>
		  <xsl:when test="$codimpuesto = 444">
			Agente de Información
		  </xsl:when>
		  <xsl:when test="$codimpuesto = 551">
			Automotor
		  </xsl:when>
		  <xsl:when test="$codimpuesto = 554">
			Embarcaciones
		  </xsl:when>
		  <xsl:when test="$codimpuesto = 555">
			Multa por COT
		  </xsl:when>
		  <xsl:when test="$codimpuesto = 611">
			Sellos
		  </xsl:when>
		  <xsl:when test="$codimpuesto = 999">
			Agentes de Recaudación / Percepción
		  </xsl:when>
		</xsl:choose>
  </xsl:template>

  
  <!-- template para el estilo de las celdas del header -->
  <xsl:template name="header-cell">
    <xsl:param name="value" />
      <fo:table-cell border="0.5pt solid black" padding="4pt">
      <fo:block font-size="8pt"> <xsl:value-of select="$value" /></fo:block>
    </fo:table-cell>
  </xsl:template>

  <!--template para el header de la tabla de deudas -->
  <xsl:template name="table-header">
    <fo:table-row>
      <xsl:call-template name="header-cell">
        <xsl:with-param name="value">
            Período
        </xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="header-cell">
        <xsl:with-param name="value">
            Vto Original
        </xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="header-cell">
        <xsl:with-param name="value">
            Deuda Original (A) $
        </xsl:with-param>
      </xsl:call-template>

      <fo:table-cell border="0.5pt solid black" padding="4pt">
        <fo:block font-size="8pt"> COEF. LIQUIDACIÓN (B)</fo:block>
          <fo:block font-size="7pt">Desde el vto. original hasta <xsl:value-of select="//fecha_liquidacion" />
          </fo:block>
      </fo:table-cell>
      

       <xsl:call-template name="header-cell">
        <xsl:with-param name="value">
            Monto Interés (C=D-A)
        </xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="header-cell">
        <xsl:with-param name="value">
            Monto Actualizado (D=AxB)
        </xsl:with-param>
      </xsl:call-template>
    </fo:table-row>
  </xsl:template>

  <!-- template para el estilo de las celdas de las deudas -->
  <xsl:template name="deuda-cell-number">
    <xsl:param name="bbw" />
    <xsl:param name="value" />

    <fo:table-cell
      padding="3pt"
      font-size="9pt"
      border-right="0.5pt solid black"
      border-left="0.5pt solid black"
      border-bottom="{$bbw}"
      text-align="right"
      >
        <fo:block> 
          <xsl:value-of select="format-number($value, '###.###,000', 'euroFormat')" /> </fo:block>
     </fo:table-cell>
  </xsl:template>

    <!-- template para el estilo de las celdas de las deudas de 2 decimales -->
  <xsl:template name="deuda-cell-number_2_decimales">
    <xsl:param name="bbw" />
    <xsl:param name="value" />

    <fo:table-cell
      padding="3pt"
      font-size="9pt"
      border-right="0.5pt solid black"
      border-left="0.5pt solid black"
      border-bottom="{$bbw}"
      text-align="right"
      >
		  
		<xsl:call-template name="deuda-cell-number_2_decimales_block">
			<xsl:with-param name="value" select="$value" />
		</xsl:call-template>	
  
     </fo:table-cell>
  </xsl:template>

  
      <!-- template para el estilo de las celdas de las deudas de 2 decimales solo block-->
  <xsl:template name="deuda-cell-number_2_decimales_block">
    <xsl:param name="value" />
			<fo:block> 
			  <xsl:value-of select="format-number($value, '###.###,00', 'euroFormat')" />
			</fo:block>
  </xsl:template>

  
  <xsl:template name="deuda-cell">
    <xsl:param name="bbw" />
    <xsl:param name="value" />

    <fo:table-cell
      text-align="right"
      padding="3pt"
      font-size="9pt"
      border-right="0.5pt solid black"
      border-left="0.5pt solid black"
      border-bottom="{$bbw}"
      >
        <fo:block> 
          <xsl:value-of select="$value" /> </fo:block>
     </fo:table-cell>
  </xsl:template>

  <!-- template para mostrar los datos de una deuda (una fila de la tabla) -->
  <xsl:template name="deuda">
    <xsl:param name="position" />

    <!-- la fila (cada celda) solo debe tener border-botoom si es la última de la página -->
    <xsl:variable name="bbw">
      <xsl:choose>
        <xsl:when test="position() = 21">0.5pt solid</xsl:when>
        <xsl:otherwise>0pt</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="deuda-cell">
      <xsl:with-param name="bbw" select="$bbw" />
      <xsl:with-param name="value">
        <xsl:if test="tipo_deuda = 'R'">
          Recargo exigible
        </xsl:if>
        <xsl:value-of select="substring(fecha_anio_cuota,5)"/>/<xsl:value-of select="substring(fecha_anio_cuota,1,4)"/>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="deuda-cell">
      <xsl:with-param name="bbw" select="$bbw" />
      <xsl:with-param name="value" select="current()/fecha_deuda" />
    </xsl:call-template>


    <xsl:call-template name="deuda-cell-number">
      <xsl:with-param name="bbw" select="$bbw" />
      <xsl:with-param name="value" select="current()/importe_deuda" />
    </xsl:call-template>

    <xsl:call-template name="deuda-cell-number">
      <xsl:with-param name="bbw" select="$bbw" />
      <xsl:with-param name="value" select="current()/indice_actualizacion" />
    </xsl:call-template>

    <xsl:choose>
      <xsl:when test="tipo_deuda != 'R'">
         <xsl:call-template name="deuda-cell-number_2_decimales">
          <xsl:with-param name="bbw" select="$bbw" />
          <xsl:with-param name="value" select="current()/importe_monto_intereses" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="deuda-cell">
          <xsl:with-param name="bbw" select="$bbw" />
          <xsl:with-param name="value" select="'0,00'" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

   

    <xsl:call-template name="deuda-cell-number_2_decimales">
      <xsl:with-param name="bbw" select="$bbw" />
      <xsl:with-param name="value" select="current()/importe_total" />
    </xsl:call-template>

  </xsl:template>

  <!--- template fila subtotal -->
  <xsl:template name="subtotal-row">

    <fo:table-cell
      text-align="right"
      number-columns-spanned="2"
      border="0.5pt solid black"
      padding="6pt"
      background-color="#ebebeb"
      >
      <fo:block>SUBTOTAL $</fo:block>
    </fo:table-cell>
    <fo:table-cell padding="6pt" border="0.5pt solid black">
      <fo:block>
        <xsl:call-template name="number-format">
          <xsl:with-param name="number" select="sum(//importe_deuda)" />
        </xsl:call-template>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell padding="6pt" border="0.5pt solid black"><fo:block></fo:block></fo:table-cell>
    <fo:table-cell padding="6pt" border="0.5pt solid black">
      <fo:block>
        <xsl:call-template name="number-format_2_decimales">
          <xsl:with-param name="number" select="sum(//deudas/deuda/importe_total) - sum(//deudas/deuda/importe_deuda)" />
        </xsl:call-template>
      </fo:block>
    </fo:table-cell>
    <fo:table-cell padding="6pt" border="0.5pt solid black">
      <fo:block>
        <xsl:call-template name="number-format_2_decimales">
          <xsl:with-param name="number" select="sum(//deudas/deuda/importe_total)" />
        </xsl:call-template>
      </fo:block>
    </fo:table-cell>
  </xsl:template>

  <!-- template para las multas -->
  <xsl:template name="multas">
    <fo:table width="12cm" text-align="center">
      <fo:table-column column-width="4cm"/>
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />
      <fo:table-column />

      <fo:table-header>
        <fo:table-row font-weight="bold" >
          <fo:table-cell number-columns-spanned="5" padding="6pt">
            <fo:block>Multas</fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-header>

      <fo:table-body>
        <xsl:for-each select="//multas/multa">
          <fo:table-row>
            <fo:table-cell text-align="left">
              <fo:block font-size="8pt" font-weight="bold">
                <xsl:choose>
                  <xsl:when test="tipo_multa = 1">
                    POR OMISIÓN
                  </xsl:when>
                  <xsl:when test="tipo_multa = 2">
                    POR DEFRAUDACIÓN
                  </xsl:when>
                  <xsl:when test="tipo_multa = 3">
                    A LOS DEBERES FORMALES
                  </xsl:when>
                  <xsl:when test="tipo_multa = 4">
                    REPOSICIÓN DE FOJAS
                  </xsl:when>
                </xsl:choose>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block font-size="8pt"> <xsl:value-of select="fecha_multa" /> </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block font-size="8pt"> <xsl:value-of select="importe_multa" /> </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block font-size="8pt"> <xsl:value-of select="indice_multa" /> </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block font-size="8pt"> <xsl:value-of select="importe_total_multa" /> </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </xsl:for-each>
        </fo:table-body>
    </fo:table>
  </xsl:template>

  <!--template para las observaciones -->
  <xsl:template name="observaciones">
    <fo:block>
      <fo:block font-weight="bold">DESCRIPCIÓN</fo:block>
      <fo:block><xsl:value-of select="datos_de_impresion/descripcion_parte_1_impresion" /></fo:block>
      <fo:block><xsl:value-of select="datos_de_impresion/descripcion_parte_2_impresion" /></fo:block>
      <fo:block><xsl:value-of select="datos_de_impresion/descripcion_alpie_impresion" /></fo:block>
    </fo:block>
    <fo:block margin-bottom="2pt" font-weight="bold">LEY APLICABLE</fo:block>
    <fo:block><xsl:value-of select="ley_aplicable"/></fo:block>
    <fo:block font-weight="bold">OBSERVACIONES</fo:block>
    <fo:block><xsl:value-of select="datos_de_impresion/observaciones_contribuyente"/></fo:block>
    <fo:block><xsl:value-of select="datos_de_impresion/observaciones_impuesto"/></fo:block>
    <fo:block><xsl:value-of select="datos_de_impresion/observacion_automatica"/></fo:block>
    <fo:block>
			<fo:table>
			 <fo:table-column column-width="35%"/>
			 <fo:table-column column-width="65%"/>
			 <fo:table-body>
			   <fo:table-row>
				 <fo:table-cell>
				   <fo:block font-weight="bold">FIRMA RESPONSABLE</fo:block>
				 </fo:table-cell>
				 <fo:table-cell>
				   <fo:block><xsl:value-of select="//personaFirmante"/></fo:block>
				 </fo:table-cell>
			   </fo:table-row>
			 </fo:table-body>
		   </fo:table>
	</fo:block>
	
    <xsl:choose>
        <xsl:when test="//firma_valida=1">
          <fo:block font-size="11pt" space-before="5mm">
            <fo:block><fo:inline font-weight="bold">LA PLATA, </fo:inline><xsl:value-of select="//fecha_alta" /></fo:block>
            <fo:block>
              <fo:inline font-weight="bold">FIRMA RESPONSABLE </fo:inline>
              <xsl:value-of select="//TituloCertificate/subject/common_name"/>
            </fo:block>
          </fo:block>
        </xsl:when>
    </xsl:choose>
  </xsl:template>

<!--
*********
Template Principal para las deudas
*********
-->

<xsl:template match="deudas" name="deudas">

  <fo:block font-size="10pt" >
    <fo:table width="27cm"  border="0.0pt solid black" text-align="left">

      <!-- DEFINICION CANTIDAD DE FILAS DE LA TABLA-->
      <fo:table-column column-number="1" column-width="5.7cm" />
      <fo:table-column column-number="2" column-width="2.8cm" />
      <fo:table-column column-width="3.7cm"/>
      <fo:table-column/>
      <fo:table-column column-width="3.9cm"/>
      <fo:table-column column-width="4.6cm" />

      <!-- HEADER DE LA TABLA -->
      <fo:table-header font-weight="bold">
        <xsl:call-template name="table-header" />
      </fo:table-header>

      <!-- CUERPO TABLA -->
      <fo:table-body>

        <!-- FILA CON LOS DATOS DE LAS DEUDAS -->
        <xsl:for-each select="deudas/deuda">
          <fo:table-row>
            <xsl:call-template name="deuda" />
          </fo:table-row>
        </xsl:for-each>

        <!-- FILA CON EL SUBTOTAL -->
        <fo:table-row font-weight="bold">
          <xsl:call-template name="subtotal-row" />
        </fo:table-row>

        <!-- aclaracion indices de liquidacion -->
        <fo:table-row font-weight="bold" font-size="9pt">
          <fo:table-cell number-columns-spanned="3" border="0.5pt solid black">
            <fo:block>Los indices de liquidación han sido aprobados por la disposición Normativa serie "A" nro. <xsl:value-of select="nro_disposicion_normativa"/>/<xsl:value-of select="anio_disposicion_normativa"/></fo:block>
          </fo:table-cell>
          <fo:table-cell text-align="center" number-columns-spanned="3" border="0.5pt solid black">
            <xsl:if test="count(//deudas/deuda[tipo_deuda = 'R']) != 0">
              <fo:block>RECARGOS CALCULADOS CONFORME RESOLUCIÓN MINISTERIAL NRO 145/2006</fo:block>
            </xsl:if>
			<fo:block></fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
      <fo:table-body>
        <!-- OBSERVACIONES Y MULTAS -->
        <fo:table-row text-align="left" >
          <!-- observaciones -->
          <fo:table-cell padding="6pt" number-columns-spanned="3" border="0.5pt solid black">
            <xsl:call-template name="observaciones" />
          </fo:table-cell>
          
          <fo:table-cell number-columns-spanned="3" padding="5pt" border="0.5pt solid black">
			
			<!-- recargos -->
			<fo:block  text-align="left" font-size="9pt">
				<fo:table>
					<fo:table-column column-width="70%"/>
					<fo:table-column column-width="30%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell>
								<fo:block>
									<xsl:value-of select="//recargos_globales/leyenda_recargos" />
								</fo:block>
							</fo:table-cell>
							<fo:table-cell>
								<xsl:call-template name="deuda-cell-number_2_decimales_block">
									<xsl:with-param name="value" select="//recargos_globales/monto_art51" />
								</xsl:call-template>	
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
			
			<!-- multas -->
		   <fo:block>
		   	  <xsl:if test="count(//multas/multa) != 0">
				<xsl:call-template name="multas" />
			</xsl:if>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
         <!-- fila con el importe total del TE -->
        <fo:table-row font-size="12pt" font-weight="bold" >
          <fo:table-cell number-columns-spanned="1" border="0.5pt solid black"
            padding="4pt" background-color="#ebebeb"
            >
            <fo:block>Total</fo:block>
          </fo:table-cell>
          <fo:table-cell
            text-align="left"
            font-weight="normal"
            font-size="10pt"
            padding="6pt"
            border="0.5pt solid black"
            number-columns-spanned="4">
            <fo:block><xsl:value-of select="//importe_total_letras"/></fo:block>
          </fo:table-cell>
          <fo:table-cell border="0.5pt solid black" padding="6pt">
            <fo:block>$<xsl:value-of select="importe_total"/></fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </fo:block>
</xsl:template>




	<xsl:template name="datos-titulo">
		<fo:table-row>
	    <fo:table-cell number-columns-spanned="2" number-rows-spanned="2">
	      <fo:block>
					 <!-- todas las imagenes y archivos usados en el template tienen que estar publicadas en internet y tener paths *absolutos* -->
	         
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell padding="1pt"  number-columns-spanned="3">
	      <fo:block  border="2pt solid black" font-weight="bold">
	        <fo:block>R-129</fo:block>
	        TITULO EJEECUTIVO
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell padding="1pt" number-columns-spanned="3">
	      <fo:block  border="0.5pt solid black">
	        <fo:block font-weight="bold" border-bottom="0.5pt solid black">IMPUESTO</fo:block>
				<xsl:call-template name="impuesto_desc">
					<xsl:with-param name="codimpuesto">
					  <xsl:value-of select="codigo_impuesto"/>
					</xsl:with-param>
				  </xsl:call-template>
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell  padding="1pt" number-columns-spanned="4">
	      <fo:block  border="0.5pt solid black">
	        <fo:block border-bottom="0.5pt solid black" font-weight="bold">CARACTER</fo:block>
	        <xsl:choose>
	          <xsl:when test="codigo_caracter = 1">
	            Bimestral
	          </xsl:when>
	          <xsl:when test="codigo_caracter = 2">
	            Agente de Recaudación / Percepción
	          </xsl:when>
	          <xsl:when test="codigo_caracter = 3">
	            Responsable
	          </xsl:when>
	          <xsl:when test="codigo_caracter = 4">
	            Mensual
	          </xsl:when>
	          <xsl:when test="codigo_caracter = 5">
	            Convenio Multilateral
	          </xsl:when>
	        </xsl:choose>
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell padding="1pt" number-columns-spanned="2">
	      <fo:block  border="0.5pt solid black">
	        <fo:block border-bottom="0.5pt solid black" font-weight="bold" >CUIT</fo:block>
	        <xsl:choose>
	        <xsl:when test="codigo_impuesto = 211">
	          <fo:block><xsl:value-of select="cuit_titulo" /></fo:block>
	        </xsl:when>
	        <xsl:otherwise>
	          -
	        </xsl:otherwise>
	      </xsl:choose>
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell number-columns-spanned="3">
	      <fo:block  border="0.5pt solid black">
	        <fo:block padding="1pt" border-bottom="0.5pt solid black" font-weight="bold">N° INDIVIDUAL</fo:block>
	         <xsl:choose>
	            <xsl:when test="codigo_impuesto = 211  and codigo_caracter = 5 ">
	              <xsl:value-of select="nro_individual_complemento" />
	            </xsl:when>
	            <xsl:when test="codigo_impuesto = 211 and codigo_caracter = 4">
	            	-
	           	</xsl:when>
	            <xsl:otherwise>
	              <!--xsl:value-of select="identificacion_impuesto" /-->
				  -
	            </xsl:otherwise>
	          </xsl:choose>
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell padding="1pt" number-columns-spanned="1">
	      <fo:block  border="0.5pt solid black">
	        <fo:block border-bottom="0.5pt solid black" font-weight="bold">TITULO</fo:block>
	        <xsl:value-of select="nro_titulo"/>
	      </fo:block>
	    </fo:table-cell>
	  </fo:table-row>
	  <fo:table-row>
	    <fo:table-cell number-columns-spanned="3">
	      <fo:block  border="0.5pt solid black">
	        <fo:block border-bottom="0.5pt solid black" font-weight="bold">EXPEDIENTE</fo:block>
	        <xsl:value-of select="nro_expediente"/>
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell number-columns-spanned="3">
	      <fo:block  border="0.5pt solid black">
	        <fo:block border-bottom="0.5pt solid black" font-weight="bold">N° DE TRÁMITE</fo:block>
	        -
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell number-columns-spanned="2">
	      <fo:block  border="0.5pt solid black">
	        <fo:block border-bottom="0.5pt solid black" font-weight="bold">Resolucion</fo:block>
	        <xsl:choose>
		        <xsl:when test="nro_resolucion_1 != 0">
		        	<xsl:value-of select="nro_resolucion_1"/> / <xsl:value-of select="anio_resolucion_1"/>
		        </xsl:when>
		        <xsl:otherwise>
		        	-
		        </xsl:otherwise>
	       	</xsl:choose>
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell number-columns-spanned="2">
	      <fo:block  border="0.5pt solid black">
	        <fo:block border-bottom="0.5pt solid black" font-weight="bold">DELEGACIÓN</fo:block>
	        <xsl:value-of select="codigo_delegacion"/>
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell number-columns-spanned="3">
	      <fo:block  border="0.5pt solid black">
	        <fo:block  border-bottom="0.5pt solid black" font-weight="bold">LIQUIDADO AL</fo:block>
	        <xsl:value-of select="fecha_liquidacion"/>
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell number-columns-spanned="3">
	      <fo:block  border="0.5pt solid black">
	        <fo:block border-bottom="0.5pt solid black" font-weight="bold">ANEXO</fo:block>
	        	<xsl:choose>
		        	<xsl:when test="count(personas/persona[es_titular = 'A']) != 0">
			        	<xsl:value-of select="count(personas/persona[es_titular = 'A'])"/>
			     	</xsl:when>
			        <xsl:otherwise>
			        	-
			        </xsl:otherwise>
			    </xsl:choose>
	      </fo:block>
	    </fo:table-cell>
	  </fo:table-row>
	</xsl:template>

	
	
	<xsl:template name="qr-codes">
     <fo:page-sequence master-reference="landscape-no-wm">
        <fo:flow font-family="monospace">
            <fo:block>Este documento digital es copia fiel de un Título Ejecutivo firmado digitalmente. Si usted desea acceder al título original (XML Firmado), ver los datos de la firma digital o descargar una copia de este documento en PDF puede hacerlo escaneando los siguientes códigos QR con su smartphone o tablet. Si está viendo este documento en un medio digital, puede hacer click sobre los hipervínculos.</fo:block>
    
    <fo:table width="16cm" space-before="20pt" text-align="center">
        <fo:table-column column-width="10cm"/>
        <fo:table-column column-width="6cm"/>        
          <fo:table-body>
              <fo:table-row>
                <fo:table-cell text-align="left">
                    <fo:block font-weight="bold" color="#128EA5" text-decoration="underline">
                        <fo:basic-link>
                            <xsl:attribute name="external-destination"><xsl:value-of select="//titulo/QrCodeData/pdf_url"/></xsl:attribute>
                            Descargar una copia de este documento
                        </fo:basic-link>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding="5pt">
                    <fo:block>
                        <fo:external-graphic content-type="image/gif">
                            <xsl:attribute name="src">url('<xsl:value-of select="//titulo/QrCodeData/pdf_qr_url"/>')</xsl:attribute>
                        </fo:external-graphic>
                    </fo:block>
                </fo:table-cell>
              </fo:table-row>
              
              <fo:table-row>
                <fo:table-cell  padding="6pt"  text-align="left">
                    <fo:block font-weight="bold" color="#128EA5" text-decoration="underline">
                       <fo:basic-link>
                            <xsl:attribute name="external-destination"><xsl:value-of select="//titulo/QrCodeData/original_url"/></xsl:attribute>
                            Descargar Título Original         
                       </fo:basic-link>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding="5pt">
                    <fo:block>
                        <fo:external-graphic content-type="image/gif">
                            <xsl:attribute name="src">url('<xsl:value-of select="//titulo/QrCodeData/original_qr_url"/>')</xsl:attribute>
                        </fo:external-graphic>
                    </fo:block>
                </fo:table-cell>
                  
              </fo:table-row>
              <fo:table-row>
                <fo:table-cell text-align="left">
                    <fo:block font-weight="bold" color="#128EA5" text-decoration="underline">
                        <fo:basic-link>
                            <xsl:attribute name="external-destination"><xsl:value-of select="//titulo/QrCodeData/view_url"/></xsl:attribute>
                            Ver Título Original         
                       </fo:basic-link>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding="5pt">
                    <fo:block>
                        <fo:external-graphic content-type="image/gif" width="4cm">
                            <xsl:attribute name="src">url('<xsl:value-of select="//titulo/QrCodeData/view_qr_url"/>')</xsl:attribute>
                        </fo:external-graphic>
                    </fo:block>
                </fo:table-cell>
                  
              </fo:table-row>
        </fo:table-body>
    </fo:table>
         </fo:flow>
    </fo:page-sequence>
  </xsl:template>

	
	

	  
  
  
</xsl:stylesheet>
