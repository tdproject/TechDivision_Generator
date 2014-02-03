<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output encoding="UTF-8" method="html"/>	
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity">                
        SET FOREIGN_KEY_CHECKS=0;
        DROP TABLE IF EXISTS <xsl:value-of select="/entity/tables/table/@name"/>;
    </xsl:template>
    
</xsl:stylesheet>