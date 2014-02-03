<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity"><xsl:if test="//entity/triggers"><xsl:for-each select="//entity/triggers/trigger">
	DELIMITER |
	CREATE TRIGGER <xsl:value-of select="@name"/><xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="@time"/><xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="@event"/> ON <xsl:value-of select="//entity/tables/table/@name"/>
		<xsl:value-of select="sql" disable-output-escaping="yes"/>
	|
	DELIMITER ;</xsl:for-each></xsl:if>
    </xsl:template>
    
</xsl:stylesheet>