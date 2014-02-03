<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
	
	<xsl:output encoding="UTF-8" method="html"/>
	
	<xsl:include href="../Utils/Utils.xsl"/>
	
	<xsl:param name="include_path_value_objects"/>
	<xsl:param name="include_path_exceptions"/>
	<xsl:param name="include_path_utils"/>
	
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Entities_<xsl:value-of select="@name"/>_Collection</xsl:variable>

        /**
         * <xsl:value-of select="description"/>
         *
         * @package Model
         * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
         * @version $Revision: 1.2 $ $Date: 2008-03-04 14:58:01 $
         * @copyright TechDivision GmbH
         * @link http://www.techdivision.com
         */
		class <xsl:value-of select="$className"/>
			extends TechDivision_Model_Collections_Abstract
		{
		
			/**
			 * (non-PHPdoc)
			 * @see TechDivision_Model_Collections_Abstract::getLocalHome()
			 */
		    public function getLocalHome()
		    {
		    	return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Utils_<xsl:value-of select="@name"/>Util::getHome($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer());
		    }
		}
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
	
</xsl:stylesheet>