<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output indent="yes" encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:template match="processor">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_<xsl:value-of select="@name"/>DelegateImplementation</xsl:variable>
		
		require_once "TechDivision/Model/Container/Implementation.php";
		require_once "TechDivision/Model/Configuration/XML.php";
		require_once "<xsl:value-of select="$namespace"/>/<xsl:value-of select="$module"/>/Common/Exceptions/DelegateException.php";
		require_once "<xsl:value-of select="$namespace"/>/<xsl:value-of select="$module"/>/Common/Delegates/Interfaces/<xsl:value-of select="@name"/>Delegate.php";
		
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
         class <xsl:value-of select="$className"/>
         	implements <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_Interfaces_<xsl:value-of select="@name"/>Delegate {
			
			/**
			 * The processor to delegate to.
			 * @var <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_Interfaces_<xsl:value-of select="@name"/>Delegate
			 */
			protected $_processor = null;
			
			/**
			 * Standardconstructor to initialize the processor.
			 *
			 * @param TDProject_Application $application The application instance
			 * @return void
			 */	    	
			 public function __construct(TDProject_Application $application) {
				$container = TechDivision_Model_Container_Implementation::getContainer($application);
				$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_processor = $container-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>lookup('<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Services_<xsl:value-of select="@name"/>', $application-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSessionId());
			}
			<xsl:for-each select="methods/method">
			/**
 	    	 * @see <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_Interfaces_<xsl:value-of select="/processor/@name"/>Delegate::<xsl:value-of select="@name"/>(<xsl:for-each select="params/param">$<xsl:value-of select="@name"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>)         
	         */
	        public function <xsl:value-of select="@name"/>(<xsl:for-each select="params/param"><xsl:if test="@type!='string' and @type!='integer' and @type!='double' and @type!='float' and @type!='boolean' and @type!='array'"><xsl:value-of select="@type"/><xsl:text disable-output-escaping="yes"> </xsl:text></xsl:if>$<xsl:value-of select="@name"/><xsl:if test="@default"> = <xsl:value-of select="@default"/></xsl:if><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>) {
		    	<xsl:choose>
		    		<xsl:when test="return/@type!='void'">return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_processor-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="@name"/>(<xsl:for-each select="params/param">$<xsl:value-of select="@name"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>);</xsl:when>
		    		<xsl:otherwise>$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_processor-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="@name"/>(<xsl:for-each select="params/param">$<xsl:value-of select="@name"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>);</xsl:otherwise>
		    	</xsl:choose>
	        }
	    </xsl:for-each>}
		
	    <xsl:text disable-output-escaping="yes">?&gt;</xsl:text>			
    </xsl:template>
</xsl:stylesheet>