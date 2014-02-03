<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity">
        <xsl:if test="//entity/tables/table/@type='View'">
            <xsl:for-each select="//entity/tables/table/sql"><xsl:value-of select="." disable-output-escaping="yes"/></xsl:for-each>;
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>