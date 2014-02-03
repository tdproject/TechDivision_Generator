<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
							  
	<xsl:output encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
			
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Exceptions_<xsl:value-of select="@name"/>CountException</xsl:variable>
		require_once "TechDivision/Model/Exceptions/CountException.php";

		class <xsl:value-of select="$className"/> 
			extends TechDivision_Model_Exceptions_CountException {
		}
		
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
	
</xsl:stylesheet>