<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" indent="no"/>
  <xsl:param name="download_url" select="//titulo/certificate_url"/>
  <xsl:template match="//titulo">
    <html>
      <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <link rel="stylesheet" href="https://www.fepba.gov.ar/pub/xslt/te/v01/html/css/bootstrap.min.css" />
        <link rel="stylesheet" href="https://www.fepba.gov.ar/pub/xslt/te/v01/html/css/style.css" />
        <script src="https://www.fepba.gov.ar/pub/xslt/te/v01/js/jquery-2.1.0.min.js"></script>
        <script src="https://www.fepba.gov.ar/pub/xslt/te/v01/js/jBox.min.js"></script>
        <link href="https://www.fepba.gov.ar/pub/xslt/te/v01/css/jBox.css" rel="stylesheet" />
        <script type="text/javascript">
          $(function(){
            new jBox('Modal', {
            width: 600,
            attach: $('#myModal'),
            title: '<img style="-webkit-user-select: none" src="http://icon.downv.com/32x32/5/391/1195284.fac1b41fcb90005d4a9e4e2dfd1a24c3.gif" /> Información del Certficiado',
            content: $("#certificate")
          });
          }); 
        </script>
      </head>
      <body>
        <xsl:apply-templates select="TituloCertificate"></xsl:apply-templates>

        <div class="container">
          <xsl:choose>
            <xsl:when test="firma_valida=1">
              <div class="ribbon valid">
                <a id="myModal">Firma Digital Válida</a>
              </div>
            </xsl:when>
            <xsl:otherwise>
              <div class="ribbon">
                <a id="myModal">Firma Digital Inválida</a>
              </div>
            </xsl:otherwise>
          </xsl:choose>
          <div id="datos-generales-titulo">
            <div class="row">
              <div class="col-md-3">
                <img class="logo" src="http://www.fepba.gov.ar/capacitacion/ttee_v2/arba.gif"/>
              </div>
              <div class="col-md-15">
                
                <div id="" class="row data-row">
                  <div class="title col-md-3">
                    <div class="title-body">
                      R-129 D <br/>
                      Titulo Ejecutivo
                    </div>
                  </div>

                  

                  <div id="impuesto" class="data-box col-md-4">
                    <div class="data-box-body">
                      <div class="heading">Impuesto</div>
                      <xsl:choose>
                        <xsl:when test="codigo_impuesto = 131">
                          Inmobiliario
                        </xsl:when>
                        <xsl:when test="codigo_impuesto = 211">
                          Ingresos Brutos
                        </xsl:when>
                        <xsl:when test="codigo_impuesto = 444">
                          Agente de Información
                        </xsl:when>
                        <xsl:when test="codigo_impuesto = 551">
                          Automotor
                        </xsl:when>
                        <xsl:when test="codigo_impuesto = 554">
                          Embarcaciones 

                        </xsl:when>
                        <xsl:when test="codigo_impuesto = 555">
                          Multa por COT
                        </xsl:when>
                        <xsl:when test="codigo_impuesto = 611">
                          Sellos
                        </xsl:when>
                        <xsl:when test="codigo_impuesto = 999">
                          Agentes de Recaudación/Percepción
                        </xsl:when>
                      </xsl:choose>
                    </div>
                  </div>
                  
                  <div id="caracter" class="data-box col-md-4">
                    <div class="data-box-body">

                      <div class="heading">Carácter</div>
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
                    </div>
                  </div>

                  <div id="cuit" class="data-box col-md-2">
                    <div class="data-box-body">
                      <div class="heading">CUIT</div>
                       <xsl:choose>
                        <xsl:when test="codigo_impuesto = 211">
                          <xsl:value-of select="identificacion_impuesto" />
                        </xsl:when>
                        <xsl:otherwise>
                          .
                        </xsl:otherwise>
                      </xsl:choose>
                    </div>
                  </div>

                  <div id="nr_individual" class="data-box col-md-3">
                    <div class="data-box-body">
                      <div class="heading">N° Individual</div>
                      <xsl:value-of select="identificacion_impuesto"/>
                    </div>
                  </div>

                  <div id="titulo" class="data-box col-md-2">
                    <div class="data-box-body">
                      <div class="heading">Título</div>
                      <xsl:value-of select="nro_titulo"/>
                    </div>
                  </div>
                </div>
                <div class="row data-row">
                  
                  <div id="expediente" class="data-box col-md-5">
                    <div class="data-box-body">
                      <div class="heading">Expediente</div>
                      <xsl:value-of select="nro_expediente"/>
                    </div>
                  </div>

                  <div id="tramite" class="data-box col-md-3">
                    <div class="data-box-body">
                      <div class="heading">N° de Trámite</div>
                      ?
                    </div>
                  </div>

                  <div id="resolucion" class="data-box col-md-2">
                    <div class="data-box-body">
                      <div class="heading">Resolución</div>
                      <xsl:value-of select="nro_resolucion_1"/>
                    </div>
                  </div>

                  <!--<div id="Dpto_judicial" class="data-box col-md-3">
                    <div class="data-box-body">
                      <div class="heading">Dpto Judicial</div>
                      <xsl:value-of select="zona_de_distribucion"/>
                    </div>
                  </div>-->
                  
                  <div id="delegacion" class="data-box col-md-2">
                    <div class="data-box-body">
                      <div class="heading">Delegación</div>
                      <xsl:value-of select="codigo_delegacion"/>
                    </div>
                  </div>
                  
                  <div id="liquidado_al" class="data-box col-md-4">
                    <div class="data-box-body">
                      <div class="heading">Liquidado al</div>
                      <xsl:value-of select="fecha_liquidacion"/>
                    </div>
                  </div>

                  <div id="liquidado_al" class="data-box col-md-2">
                    <div class="data-box-body">
                      <div class="heading">Anexo</div>
                      <xsl:value-of select="count(personas/persona[es_titular = 'A'])" />
                    </div>
                  </div>

                </div>

              </div>
            </div>
          </div>

          <div id="datos-titular">
            <xsl:apply-templates select="personas/persona[es_titular= 'T']"></xsl:apply-templates>
          </div>
          
          <div id="datos-deudas">
            <xsl:apply-templates select="deudas"/>
          </div>
          <!--<div id="datos-multas">
            <xsl:apply-templates select="multas"></xsl:apply-templates>
          </div>
          <div id="datos-deuda-total">
            <hr class="dashed"/>
            <h3 class="table-heading">DEUDA TOTAL</h3>
            <table class="table table-bordered table-total">
            <tr>
              <td>DEUDAS</td>
              <td class="value">
                $<xsl:value-of select="sum(deudas/deuda/importe_total)"/>
              </td>
            </tr>
            <tr>
              <td>MULTAS</td>
              <td class="value">
                $<xsl:value-of select="sum(multas/multa/importe_total_multa)"/>
              </td>
            </tr>
            <tr class="active total">
              <td>TOTAL</td>
              <td class="value">
                $<xsl:value-of select="importe_total"/>
              </td>
            </tr>
          </table>
          </div>-->
        </div>
        <div class="container">
          <xsl:call-template name="titulares" />
        </div>
        <div class="container">
          <xsl:call-template name="planes" />
        </div>
      </body>
    </html>
  </xsl:template>

<xsl:template match="TituloCertificate">
<div id="certificate" style="display:none">
  <div class="list-group">
    <div class="list-group-item">
      <h5 class="list-group-item-heading">Emisor</h5>
      <div class="list-group-item-text">
        <dl class="dl-horizontal">
          <dt>Nombre</dt>
          <dd>
            <xsl:value-of select="issuer/common_name"/>
          </dd>
          <dt>Email</dt>
          <dd>
            <xsl:value-of select="issuer/email"/>
          </dd>
          <dt>Organización</dt>
          <dd>
            <xsl:value-of select="issuer/organization"/>
          </dd>
          <dt>Unidad Organizativa</dt>
          <dd>
            <xsl:value-of select="issuer/organizational_unit"/>
          </dd>
        </dl>
      </div>
    </div>
    <div class="list-group-item">
      <h5 class="list-group-item-heading">Sujeto</h5>
      <div class="list-group-item-text">
        <dl class="dl-horizontal">
          <dt>Nombre</dt>
          <dd>
            <xsl:value-of select="subject/common_name"/>
          </dd>
          <dt>Email</dt>
          <dd>
            <xsl:value-of select="subject/email"/>
          </dd>
          <dt>Organización</dt>
          <dd>
            <xsl:value-of select="subject/organization"/>
          </dd>
          <dt>Unidad Organizativa</dt>
          <dd>
            <xsl:value-of select="subject/organizational_unit"/>
          </dd>
        </dl>
      </div>
    </div>
    <div class="list-group-item">
      <h5 class="list-group-item-heading">Usos</h5>
      <div class="list-group-item-text">
        <ul>
          <xsl:for-each select="uses/CertificateUse">
          <li>
            <xsl:value-of select="description"/>
          </li>
          </xsl:for-each>
        </ul>
      </div>
    </div>
    <div class="list-group-item">
      <h5 class="list-group-item-heading">Validez</h5>
      <p class="list-group-item-text">
        Desde <span class="text-primary"><xsl:value-of select="valid_from"/></span> 
        Hasta <span class="text-primary"><xsl:value-of select="valid_to"/></span>
      </p>
    </div>
  </div>
  <a href="{$download_url}" class="btn btn-primary">Descargar Certificado</a>
</div>
</xsl:template>

<xsl:template match="domicilioFiscal">
	<div class="data-box">
		<div class="heading">Domicilio Fiscal</div>
		<xsl:value-of select="calle"/> #<xsl:value-of select="nro" />,
		<xsl:if test="piso">
			<xsl:value-of select="piso"/>° <xsl:value-of select="depto"/>
		</xsl:if>,
		<xsl:value-of select="localidad"/>
	</div>
</xsl:template>

<xsl:template match="recargos_globales">
</xsl:template>

<xsl:template match="deudas">
    <hr class="dashed"/>
    <table class="table table-bordered table-consended table-some-borders">
      <thead>
        <tr class="reduced-size">
          <th>Período</th>
          <th>Vto. Original</th>
          <th>Saldo (A) $</th>
          <th>Coef. Liquidación (B) <br/>
          	Desde el vto. original hasta   <xsl:value-of select="//fecha_liquidacion"/>

          </th>
          <th>Monto Interés (C=D-A)</th>
          <th>Monto Actualizado(D=AxB)</th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="deuda">
          <tr class="notop">
            <td class="col-md-3">
              <xsl:value-of select="fecha_a_cuota"/>
            </td>
            <td class="col-md-3">
              <xsl:value-of select="fecha_saldo"/>
            </td>
            <td class="col-md-3">
              <xsl:value-of select="importe_deuda"/>
            </td>
            <td class="col-md-3">
              <xsl:value-of select="indice_actualizacion"/>
            </td>
            <td class="col-md-3">
              <xsl:value-of select="importe_total - importe_deuda"/>
            </td>
            <td class="col-md-4">
              <xsl:value-of select="importe_total"/>
            </td>
          </tr>
        </xsl:for-each>
        <tr>
          <td class="active bold" colspan="2">SUBTOTAL $</td>
          <td class="bold">
            <xsl:value-of select="sum(//importe_deuda)"/>
          </td>
          <td></td>
          <td class="bold">
            <xsl:value-of select="sum(deuda/importe_total) - sum(deuda/importe_deuda)"/>
          </td>
          <td class="bold">
            <xsl:value-of select="sum(deuda/importe_total)"/>
          </td>
        </tr>
        <tr>
          <td colspan="3" class="bold small-text center">Los indices de liquidación han sido aprobados por la disposición Normativa serie "A" nro. <xsl:value-of select="//nro_disposicion_normativa"/>/<xsl:value-of select="//anio_disposicion_normativa"/></td>
          <td colspan="3">
          </td>
        </tr>
        <tr>
          <xsl:apply-templates select="//multas"/>
        </tr>
        <tr>
          <td colspan="1" class="active bold">TOTAL</td>
          <td colspan="4" class="upper">
          	Son pesos
          	<strong>
              <xsl:value-of select="//importe_total_letras" />
		    </strong>
          </td>
          <td>
          		

                $<xsl:value-of select="//importe_total"/>
          </td>
        </tr>
      </tbody>
    </table>
</xsl:template>

<xsl:template match="multas">
    <td colspan="3" class="small-text">
      <div>
        <h5>Descripccion</h5>
        <p>
          <xsl:value-of select="//datos_de_impresion/descripcion_parte_1_impresion"/>
          <br/>
          <xsl:value-of select="//datos_de_impresion/descripcion_parte_2_impresion"/>
          <br/>
          <xsl:value-of select="//datos_de_impresion/descripcion_alpie_impresion"/>
      </p>
      </div>
      <div>
        <h5>Ley Aplicable</h5>
        <xsl:value-of select="//ley_aplicable"/>
      </div>
      <div>
        <h5>Observaciones</h5>
        <xsl:value-of select="//datos_de_impresion/observaciones_contribuyente"/>
        <xsl:value-of select="//datos_de_impresion/observaciones_impuesto"/>
      </div>
    </td>
    <td colspan="3" class="center">
      <h5>Multas</h5>
      <table class="table table-condensed no-borders">
        <tbody>
          <xsl:for-each select="multa">
            <tr>
              <td>
                <xsl:choose>
                  <xsl:when test="tipo_multa = 1">
                    Por Omisión
                  </xsl:when>
                  <xsl:when test="tipo_multa = 2">
                    Por defraudación
                  </xsl:when>
                  <xsl:when test="tipo_multa = 3">
                    A los deberes formales
                  </xsl:when>
                  <xsl:when test="tipo_multa = 4">
                    Reposición de fojas
                  </xsl:when>
                </xsl:choose>
              </td>
              <td>
                <xsl:value-of select="fecha_multa"/>
              </td>
              <td>
                <xsl:value-of select="importe_multa"/>
              </td>
              <td>
                <xsl:value-of select="indice_multa"/>
              </td>
              <td>
                <xsl:value-of select="importe_total_multa"/>
              </td>
            </tr>
        </xsl:for-each>
        </tbody>
      </table>
    </td>
</xsl:template>

<xsl:template match="personas/persona[es_titular = 'T']" name="titular">
    <div class="titular">
      <div class="row data-row">
        <div id="" class="data-box col-md-8">
          <div class="data-box-body">
            <div class="heading">Apellido y Nombre / Razón Social</div>
            <xsl:value-of select="apellido"/>, <xsl:value-of select="nombre"/>
          </div>
        </div>

        <div id="" class="data-box col-md-4">
          <div class="data-box-body">
            <div class="heading">Tipo y N° de Documento</div>
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
              <xsl:otherwise>
                -
              </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="numero_documento"/>
          </div>
        </div>

        <div id="" class="data-box col-md-3">
          <div class="data-box-body">
            <div class="heading">CUIT titular</div>
            <xsl:value-of select="cuit"/>
          </div>
        </div>

        <div id="" class="data-box col-md-3">
          <div class="data-box-body">
            <div class="heading">NACIONALIDAD</div>
            <xsl:choose>
              <xsl:when test="nacionalidad!=''">
                <xsl:value-of select="nacionalidad"/>
              </xsl:when>
              <xsl:otherwise>
                -
              </xsl:otherwise>
            </xsl:choose>
          </div>
        </div>
      </div>
      <div class="row data-row">
        <div id="" class="data-box col-md-9">
          <div class="data-box-body">
            <div class="heading">Domicilio Fiscal</div>
            <xsl:value-of select="//domicilioFiscal/calle"/> #<xsl:value-of select="//domicilioFiscal/nro" />,
            <xsl:if test="//domicilioFiscal/piso">
              <xsl:value-of select="//domicilioFiscal/piso"/>° <xsl:value-of select="//domicilioFiscal/depto"/>
            </xsl:if>,
            <xsl:value-of select="//domicilioFiscal/localidad"/>
          </div>
        </div>
        <div id="" class="data-box col-md-9">
          <div class="data-box-body">
            <div class="heading">Domicilio Particular</div>
            -
          </div>
        </div>
      </div>

    </div>
</xsl:template>
  
<xsl:template match="personas" name="titulares">
    <div class="anexo-heading clearfix">
      <div class="anexo-tag">
        Anexo
      </div>
      <div class="anexo-title">
        Codeudores
      </div>
    </div>
    <xsl:for-each select="//persona[es_titular = 'A']">
      <div class="codeudor">
        <div class="row data-row">
          <div id="" class="data-box col-md-7">
            <div class="data-box-body">
              <div class="heading">Apellido y Nombre / Razón Social</div>
              <xsl:value-of select="apellido"/>, <xsl:value-of select="nombre"/>
            </div>
          </div>

          <div id="" class="data-box col-md-4">
            <div class="data-box-body">
              <div class="heading">Tipo y N° de Documento</div>
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
              </xsl:choose>
              <xsl:value-of select="numero_documento"/>
            </div>
          </div>

          <div id="" class="data-box col-md-4">
            <div class="data-box-body">
              <div class="heading">CUIT</div>
              <xsl:value-of select="cuit"/>
            </div>
          </div>

          <div id="" class="data-box col-md-3">
            <div class="data-box-body">
              <div class="heading">NACIONALIDAD</div>
              <xsl:choose>
                <xsl:when test="nacionalidad!=''">
                  <xsl:value-of select="nacionalidad"/>
                </xsl:when>
                <xsl:otherwise>
                  -
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </div>
        </div>
        <div class="row data-row">
        	<div class="data-box col-md-18">
        		<div class="data-box-body">
	              <div class="heading">Domicilios</div>
		            <xsl:for-each select="domicilios/domicilio">
			        	<div class="domicilio-codeudor">
				            <div class="row">
			              		<div class="col-md-6">
			              			<span class="label">CALLE:</span>
			              			<xsl:value-of select="calle"/>
			              		</div>
			              		<div class="col-md-4">
			              			<span class="label">NÚMERO:</span>
			              			<xsl:value-of select="nro"/>
			              		</div>
			              		<div class="col-md-4">
			              			<span class="label">PISO:</span>
			              			<xsl:value-of select="piso"/>
			              		</div>
			              		<div class="col-md-4">
			              			<span class="label">DEPTO.:</span>
			              			<xsl:value-of select="depto"/>
			              		</div>
			              	</div>
			              	<div class="row">
			              		<div class="col-md-6">
			              			<span class="label">LOCALIDAD:</span>
			              			<xsl:value-of select="localidad"/>
			              		</div>
			              		<div class="col-md-4">
			              			<span class="label">COD.POS:</span>
			              			<xsl:value-of select="codigo_postal"/>
			              		</div>
			              		<div class="col-md-4">
			              			<span class="label">ANEXO:</span>
			              			<xsl:value-of select="nro_complemento"/>
			              		</div>
			              	</div>
			            </div>
			          </xsl:for-each>
	            </div>
        	</div>
        </div>
      </div>
    </xsl:for-each>
</xsl:template>

<xsl:template match="planes_caducos" name="planes">
  <div class="anexo-heading clearfix">
      <div class="anexo-tag">
        Anexo
      </div>
      <div class="anexo-title">
        Planes caducos
      </div>
  </div>
  <xsl:for-each select="plan_caduco">
      <h3>Plan caduco</h3>
      <hr/>
      <div class="descripcion-plan"><p><xsl:value-of select="descripcion_global"/></p></div>
      <div class="plan-table-container">
      <table class="table table-bordered table-consended table-some-borders">
        <thead>
          <tr class="no-borders medium-size">
            <th colspan="4" class="">DETALLE DE LIQUIDACIÓN PLAN DE PAGO</th>
            <th colspan="2">LEY 12.914 CAP. I.4</th>
            <th colspan="1">
              AL <xsl:value-of select="//fecha_liquidacion"/>
            </th>
          </tr>
          <tr class="">
            <th colspan="7" class="bold center">VALOR A COMPUTAR POR LOS PERIODOS INCLUIDOS EN EL PLAN DE PAGOS(*)</th>
          </tr>
          <tr class="reduced-size">
            <th>Plan anterior reformulado</th>
            <th>Período original incluido en el Plan</th>
            <th>Deuda Original (A)</th>
            <th>Vencimiento Original</th>
            <th>Coeficiente de Liquidación (B)</th>
            <th>Monto Interés (C=D-A)</th>
            <th>MONTO ACTUALIZADO (D=AXB)$</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="deudas_plan_caduco/deuda_plan_caduco">
            <tr class="notop">
              <td>
                <xsl:value-of select="descripcion_plan_incluido"/>
              </td>
              <td>
                <xsl:value-of select="periodo_deuda"/>
              </td>
              <td>
                <xsl:value-of select="importe_deuda"/>
              </td>
              <td>
                <xsl:value-of select="fecha_vencimiento"/>
              </td>
              <td>
                <xsl:value-of select="indice_actualizacion"/>
              </td>
              <td>
                <xsl:value-of select="importe_intereses"/>
              </td>
              <td>
                <xsl:value-of select="importe_total_periodo"/>
              </td>
            </tr>
          </xsl:for-each>
          <tr>
            <td colspan="6" class="bold">
              VALOR AL <xsl:value-of select="//fecha_liquidacion"/> DE LOS PERIODOS ORIGINALES INCLUIDOS EN EL PLAN(1)
            </td>
            <td>
              <xsl:value-of select="importe_deuda"/>
            </td>
          </tr>
        </tbody>
      </table>
      <small>(*) Detalle de los períodos / valores originales incluidos en el plan de pagos caducos, con la determinación de intereses, computados desde su vencimiento hasta la fecha de liquidación del TE.</small>
    </div>
      <div class="plan-table-container">
      <table class="table table-bordered table-consended table-some-borders">
        <thead>
          <tr class="">
            <th colspan="6" class="bold center">VALOR A COMPUTAR POR LAS CUOTAS PAGAS(**)</th>
          </tr>
          <tr class="reduced-size">
            <th>Plan de Pago</th>
            <th>Fecha de Pago</th>
            <th>Importe Cuota Plan Abonado (A)</th>
            <th>Coeficiente de Liquidación (B)</th>
            <th>Pago Actualizado(C=AXB)$</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
           <xsl:for-each select="pagos_plan_caduco/pago_plan_caduco">
          <tr class="notop">
             <td>
              <xsl:value-of select="descripcion_plan_pago"/>
             </td>
             <td>
              <xsl:value-of select="fecha_pago"/>
             </td>
             <td>
               <xsl:value-of select="importe_cuota_plan_abonado"/>    
             </td>
             <td>
              <xsl:value-of select="coeficiente_liquidacion_cuota"/>   
            </td>
             <td>
               <xsl:value-of select="importe_pagado_actualizado"/>
             </td>
            <td>
            </td>
          </tr>

          </xsl:for-each>
          <tr class="reduced-size notop">
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="center yestop">MONTO DE caducidad<br/>3=1-2</td>
          </tr>
            <tr >
            <td colspan="5">MONTO A DESCONTAR</td>
            <td>
              <xsl:value-of select="importe_total_pagos"/>
            </td>
          </tr>
        </tbody>
      </table>
      <small> (**)Detalle de los pagos realizados por el plan caduco. Se computa el valor de origen de las cuotas pagas por su importe total, actualizados desde la fecha del efectivo pago hasta la fecha de liquidación del TE.</small>
    </div>  
  </xsl:for-each>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>


