<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity">
    	<xsl:if test="//entity/procedures">
    	<xsl:for-each select="//entity/procedures/procedure">
    	DROP PROCEDURE IF EXISTS <xsl:value-of select="@name"/>;
    	DELIMITER |
    		CREATE PROCEDURE <xsl:value-of select="@name"/>(<xsl:for-each select="procedure-params/procedure-param"><xsl:value-of select="@direction"/><xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="@name"/><xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="@type"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>)
    		BEGIN
    		<xsl:value-of select="sql" disable-output-escaping="yes"/>
    		END; 
    	|
    	DELIMITER ;
    	</xsl:for-each>
    	</xsl:if>
    </xsl:template>
    
</xsl:stylesheet>