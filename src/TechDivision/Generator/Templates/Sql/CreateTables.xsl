<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity">
        <xsl:if test="//entity/tables/table/@type!='View'">
        CREATE TABLE `<xsl:value-of select="//entity/tables/table/@name"/>` (<xsl:for-each select="//entity/tables/table/fields/field">`<xsl:value-of select="@name"/>`<xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="@type"/><xsl:if test="@length">(<xsl:value-of select="@length"/>)</xsl:if><xsl:if test="@nullable='false'"><xsl:text disable-output-escaping="yes"> </xsl:text>NOT NULL</xsl:if><xsl:if test="@default"><xsl:text disable-output-escaping="yes"> default </xsl:text><xsl:value-of select="@default"/></xsl:if><xsl:if test="@on-update"><xsl:text disable-output-escaping="yes"> on update </xsl:text><xsl:value-of select="@on-update"/></xsl:if><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>)<xsl:if test="//entity/tables/table/@default-charset"> DEFAULT CHARSET=<xsl:value-of select="//entity/tables/table/@default-charset"/></xsl:if><xsl:if test="//entity/tables/table/@collate"> COLLATE=<xsl:value-of select="//entity/tables/table/@collate"/></xsl:if><xsl:if test="//entity/tables/table/@auto-increment"> AUTO_INCREMENT=<xsl:value-of select="//entity/tables/table/@auto-increment"/></xsl:if> ENGINE=<xsl:value-of select="//entity/tables/table/@type"/>;
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>