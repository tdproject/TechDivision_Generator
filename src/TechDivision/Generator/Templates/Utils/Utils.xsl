<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
	
	<xsl:output encoding="UTF-8" method="html"/>	

	<xsl:include href="./String.xsl"/>
	
	<xsl:template name="capitalize">
		<xsl:param name="text"/>
			<xsl:choose>
			<xsl:when test="contains($text, '_')">		
				<xsl:call-template name="str:to-camelcase">
					<xsl:with-param name="text">		
						<xsl:value-of select="translate($text, '_', ' ')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="str:capitalise">
					<xsl:with-param name="text">		
						<xsl:value-of select="substring($text, 1, 1)"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="substring($text, 2, string-length($text))"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="beginlowercase">
		<xsl:param name="text"/>
			<xsl:choose>
			<xsl:when test="contains($text, '_')">		
				<xsl:call-template name="str:to-camelcase">
					<xsl:with-param name="text">		
						<xsl:value-of select="translate($text, '_', ' ')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="str:to-lower">
					<xsl:with-param name="text">		
						<xsl:value-of select="substring($text, 1, 1)"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:value-of select="substring($text, 2, string-length($text))"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>