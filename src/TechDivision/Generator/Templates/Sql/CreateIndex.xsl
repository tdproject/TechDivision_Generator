<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity"><xsl:if test="/entity/tables/table/keys/index">
        <xsl:for-each select="/entity/tables/table/keys/index">CREATE INDEX <xsl:value-of select="@name"/> ON `<xsl:value-of select="/entity/tables/table/@name"/>` (`<xsl:value-of select="@field"/>`);
        </xsl:for-each></xsl:if>
        <xsl:if test="//entity/tables/table/keys/index-multi"><xsl:for-each select="//entity/tables/table/keys/index-multi">CREATE INDEX <xsl:value-of select="@name"/> ON `<xsl:value-of select="//entity/tables/table/@name"/>` (<xsl:for-each select="columns/column">`<xsl:value-of select="."/>`<xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>);
        </xsl:for-each></xsl:if>
    </xsl:template>
    
</xsl:stylesheet>