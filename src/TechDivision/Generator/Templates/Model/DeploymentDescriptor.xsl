<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">

    <xsl:output encoding="UTF-8" method="html"/>
    
    <xsl:include href="../Utils/Utils.xsl"/>
	
	<xsl:param name="include_path_value_objects"/>
	<xsl:param name="include_path_exceptions"/>
	<xsl:param name="include_path_utils"/>
    <xsl:param name="include_path_services"/>

    <!-- Renders the entity informations -->
    <xsl:template match="entity">
        <entity>
            <xsl:attribute name="name"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Entities_<xsl:value-of select="@name"/></xsl:attribute>
            <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
            <path><xsl:value-of select="$include_path_entities"/></path>
            <file><xsl:value-of select="@name"/>.php</file>
        </entity>
    </xsl:template>
    
    <!-- Renders the processor informations -->
    <xsl:template match="processor">
        <entity>
            <xsl:attribute name="name"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Services_<xsl:value-of select="@name"/></xsl:attribute>
            <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
            <applications>
                <application><xsl:value-of select="@default-application"/></application>
            </applications>
            <path><xsl:value-of select="$include_path_services"/></path>
            <file><xsl:value-of select="@name"/>.php</file>
        </entity>
    </xsl:template>
    
</xsl:stylesheet>