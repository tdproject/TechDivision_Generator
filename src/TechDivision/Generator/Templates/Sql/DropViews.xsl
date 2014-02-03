<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity">
    	<xsl:if test="//entity/tables/table/@type='View'">
        	DROP VIEW IF EXISTS <xsl:value-of select="/entity/tables/table/@name"/>;
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>