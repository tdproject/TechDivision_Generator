<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity">
    	<xsl:if test="/entity/tables/table/initial-data/rows/row"><xsl:for-each select="/entity/tables/table/initial-data/rows/row">
    	INSERT INTO `<xsl:value-of select="../../../@name"/>` VALUES (<xsl:for-each select="col"><xsl:call-template name="values"><xsl:with-param name="value" select="."/></xsl:call-template><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>);</xsl:for-each></xsl:if>
    </xsl:template>
    
    <xsl:template name="values">
    	<xsl:param name="value"/>
    	
    	<xsl:choose>
    		<xsl:when test="$value=''">NULL</xsl:when>
    		<xsl:when test="$value='NULL'"><xsl:value-of select="$value"/></xsl:when>
    		<xsl:otherwise>'<xsl:value-of select="$value"/>'</xsl:otherwise>
    	</xsl:choose>
    
    </xsl:template>
    
</xsl:stylesheet>