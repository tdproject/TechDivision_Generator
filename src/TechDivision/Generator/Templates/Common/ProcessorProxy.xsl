<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output indent="yes" encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:template match="processor">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="proxyClassName"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Services_<xsl:value-of select="@name"/>Proxy</xsl:variable>
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Services_<xsl:value-of select="@name"/></xsl:variable>	
		
		require_once 'TechDivision/Lang/String.php';
        require_once 'TechDivision/ApplicationServerClient/Proxy.php';
        require_once 'TechDivision/ApplicationServerClient/RemoteMethodCall.php';
		
        /**
	     * <xsl:value-of select="description"/>
         * 
         * @package common
         * @subpackage delegates
         * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
         * @version $Revision: 1.1 $ $Date: 2007-10-25 16:09:14 $
         * @copyright TechDivision GmbH
         * @link http://www.techdivision.com 
         */
         class <xsl:value-of select="$proxyClassName"/>
            extends TechDivision_ApplicationServerClient_Proxy
            implements <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_Interfaces_<xsl:value-of select="/processor/@name"/>Delegate {

			<xsl:for-each select="methods/method">
			/**
 	    	 * @see <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_Interfaces_<xsl:value-of select="/processor/@name"/>::<xsl:value-of select="@name"/>(<xsl:for-each select="params/param">$<xsl:value-of select="@name"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>)         
	         */
	        public function <xsl:value-of select="@name"/>(<xsl:for-each select="params/param"><xsl:if test="@type!='string' and @type!='integer' and @type!='double' and @type!='float' and @type!='boolean' and @type!='array'"><xsl:value-of select="@type"/><xsl:text disable-output-escaping="yes"> </xsl:text></xsl:if>$<xsl:value-of select="@name"/><xsl:if test="@default"> = <xsl:value-of select="@default"/></xsl:if><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>) {
		 		$methodCall = new TechDivision_ApplicationServerClient_RemoteMethodCall(new TechDivision_Lang_String('<xsl:value-of select="$className"/>'), '<xsl:value-of select="@name"/>', $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSession()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSessionId());
		 		<xsl:if test="params"><xsl:for-each select="params/param">$methodCall-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>addParameter('<xsl:value-of select="@name"/>', $<xsl:value-of select="@name"/>);</xsl:for-each></xsl:if>
		 		return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>__invoke($methodCall, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSession());
	        }
	    </xsl:for-each>}
		
	    <xsl:text disable-output-escaping="yes">?&gt;</xsl:text>			
    </xsl:template>
</xsl:stylesheet>