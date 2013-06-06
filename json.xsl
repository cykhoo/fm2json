<?xml version="1.0" encoding="UTF-8"?>

<?xslt-cwp-query params="-grammar=fmresultset"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fmrs="http://www.filemaker.com/xml/fmresultset">

<xsl:output encoding="UTF-8" indent="yes" method="text"/>

<xsl:template match="/fmrs:fmresultset">{
 'errorCode':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:error/@code"/></xsl:call-template>',
 'datasource':
 {
  'database':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:datasource/@database"/></xsl:call-template>',
  'dateFormat':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:datasource/@date-format"/></xsl:call-template>',
  'layout':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:datasource/@layout"/></xsl:call-template>',
  'table':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:datasource/@table"/></xsl:call-template>',
  'timeFormat':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:datasource/@time-format"/></xsl:call-template>',
  'timestampFormat':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:datasource/@timestamp-format"/></xsl:call-template>',
  'totalCount':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:datasource/@total-count"/></xsl:call-template>'
 },
 'fieldDefinitions':
 [
  <xsl:for-each select="./fmrs:metadata/fmrs:field-definition">{
   'name':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./@name"/></xsl:call-template>',
   'autoEnter':<xsl:choose><xsl:when test="./@auto-enter = 'yes'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
   'global':<xsl:choose><xsl:when test="./@global = 'yes'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
   'maxRepeat':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./@max-repeat"/></xsl:call-template>',
   'notEmpty':<xsl:choose><xsl:when test="./@not-empty = 'yes'">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>,
   'result':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./@result"/></xsl:call-template>',
   'type':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./@type"/></xsl:call-template>'
  }<xsl:if test="position() != last()">,</xsl:if>
 </xsl:for-each>],
 'resultset':
 {
  'count':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:resultset/@count"/></xsl:call-template>',
  'fetchSize':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./fmrs:resultset/@fetch-size"/></xsl:call-template>',
  'records':
  [<xsl:for-each select="./fmrs:resultset/fmrs:record">
   {
    'modId':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./@mod-id"/></xsl:call-template>',
    'recordId':'<xsl:call-template name="escape"><xsl:with-param name="text" select="./@record-id"/></xsl:call-template>',
    'fields':
    {<xsl:for-each select="./fmrs:field">
     '<xsl:call-template name="escape"><xsl:with-param name="text" select="./@name"/></xsl:call-template>':[<xsl:for-each select="./fmrs:data">'<xsl:call-template name="escape"><xsl:with-param name="text" select="./text()"/></xsl:call-template>'<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>]<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
    }
   }<xsl:if test="position() != last()">,</xsl:if>
</xsl:for-each>
  ]
 }
}</xsl:template>

<xsl:template name="escape">
   <xsl:param name="text"/>
   <xsl:variable name="from">'</xsl:variable>
   <xsl:variable name="to">\'</xsl:variable>

   <xsl:choose>
     <xsl:when test="contains($text, $from)">

		<xsl:variable name="before" select="substring-before($text, $from)"/>
		<xsl:variable name="after" select="substring-after($text, $from)"/>
		<xsl:variable name="prefix" select="concat($before, $to)"/>

		<xsl:value-of select="$before"/>
		<xsl:value-of select="$to"/>
      <xsl:call-template name="escape"><xsl:with-param name="text" select="$after"/></xsl:call-template>
     </xsl:when> 
     <xsl:otherwise>
       <xsl:value-of select="$text"/>  
     </xsl:otherwise>
   </xsl:choose>            
</xsl:template>

</xsl:stylesheet>