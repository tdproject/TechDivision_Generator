<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output indent="yes" encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>

    /**
     * This class provides methods needed to
     * access the data from the database.
     *
     * @package epb
     * @subpackage homes
     * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
     * @version $Revision: 1.1 $ $Date: 2007-12-14 13:53:15 $
     * @copyright TechDivision GmbH
     * @link http://www.techdivision.com
     */
	class <xsl:value-of select="@name"/>QueryUtil {
	
        /**
         * Private constructor to mark this class as
         * a utiltiy class.
         *
         * @return void
         */
		private function __construct() {}

		<xsl:for-each select="querys/query">
		/**
		 * <xsl:value-of select="description"/>
		 * @var string
		 */
		const <xsl:value-of select="method/@name"/> = "<xsl:value-of disable-output-escaping="yes" select="sql"/>";
		</xsl:for-each>	
	}
<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
</xsl:stylesheet>