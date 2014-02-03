<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">

    <xsl:output encoding="UTF-8" method="html"/>

    <xsl:include href="../Utils/Utils.xsl"/>

    <xsl:template match="entity">
        <xsl:for-each select="/entity/tables/table">
            <xsl:value-of select="@name"/>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
