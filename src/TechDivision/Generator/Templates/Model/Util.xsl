<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
	
	<xsl:output encoding="UTF-8" method="html"/>	

	<xsl:include href="../Utils/Utils.xsl"/>
		
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Utils_<xsl:value-of select="@name"/>Util</xsl:variable>
		
		require_once "<xsl:value-of select="$include_path_homes"/><xsl:value-of select="@name"/>LocalHome.php";

		class <xsl:value-of select="$className"/> 
		{
		
			/**
			 * Holds the home of the <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Entities_<xsl:value-of select="@name"/> entity
			 * @var <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Homes_<xsl:value-of select="@name"/>LocalHome
			 */
	        protected static $_home = null;		
	
			/**
			 * Returns the home of the <xsl:value-of select="@name"/> entity
			 *
			 * @param TechDivision_Model_Interfaces_Container $container The container instance
			 * @return <xsl:value-of select="@name"/>Home Holds the home of the <xsl:value-of select="@name"/> entity
			 */
			public function getHome(TechDivision_Model_Interfaces_Container $container) {
				if (<xsl:value-of select="$className"/>::$_home == null) {
					<xsl:value-of select="$className"/>::$_home = $container-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>newInstance('<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Homes_<xsl:value-of select="@name"/>LocalHome', array($container));
				}
				return <xsl:value-of select="$className"/>::$_home;
			}
		}
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
</xsl:stylesheet>