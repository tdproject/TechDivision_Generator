<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity"><xsl:if test="/entity/tables/table/keys/fk">
        <xsl:for-each select="/entity/tables/table/keys/fk">
        ALTER TABLE `<xsl:value-of select="/entity/tables/table/@name"/>` ADD CONSTRAINT <xsl:value-of select="@name"/> FOREIGN KEY (`<xsl:value-of select="@field"/>`) REFERENCES `<xsl:value-of select="@target-table"/>` (`<xsl:value-of select="@target-field"/>`)<xsl:if test="@on-delete"> ON DELETE <xsl:call-template name="constrainttypes"><xsl:with-param name="constraint"><xsl:value-of select="@on-delete"/></xsl:with-param></xsl:call-template></xsl:if><xsl:if test="@on-update"> ON UPDATE <xsl:call-template name="constrainttypes"><xsl:with-param name="constraint"><xsl:value-of select="@on-update"/></xsl:with-param></xsl:call-template></xsl:if>;
        </xsl:for-each></xsl:if>
    </xsl:template>
    
    <xsl:template name="constrainttypes">
        <xsl:param name="constraint"/>
        <xsl:choose>
            <xsl:when test="$constraint='null'">SET NULL</xsl:when>
            <xsl:when test="$constraint='nothing'">NO ACTION</xsl:when>
            <xsl:when test="$constraint='cascade'">CASCADE</xsl:when>
            <xsl:when test="$constraint='restrict'">RESTRICT</xsl:when>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>