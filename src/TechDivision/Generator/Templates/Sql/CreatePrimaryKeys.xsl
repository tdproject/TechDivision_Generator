<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity">
        <xsl:if test="//entity/tables/table/@type!='View'">
        ALTER TABLE `<xsl:value-of select="/entity/tables/table/@name"/>` ADD<xsl:for-each select="//entity/tables/table/keys/pk"> CONSTRAINT <xsl:value-of select="@name"/> PRIMARY KEY (`<xsl:value-of select="@field"/>`)<xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>; 
        ALTER TABLE `<xsl:value-of select="/entity/tables/table/@name"/>` CHANGE <xsl:for-each select="//entity/tables/table/keys/pk"><xsl:variable name="field" select="@field"/><xsl:value-of select="@field"/><xsl:text disable-output-escaping="yes"> </xsl:text>`<xsl:value-of select="@field"/>`<xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="//entity/tables/table/fields/field[@name=$field]/@type"/>(<xsl:value-of select="//entity/tables/table/fields/field[@name=$field]/@length"/>) AUTO_INCREMENT</xsl:for-each>;
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>