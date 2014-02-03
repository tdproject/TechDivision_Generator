<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output indent="yes" encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:template match="processor">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_<xsl:value-of select="@name"/>DelegateUtil</xsl:variable>
		
		require_once "TechDivision/Properties/Properties.php";		
		require_once "<xsl:value-of select="$namespace"/>/<xsl:value-of select="$module"/>/Common/Delegates/<xsl:value-of select="@name"/>DelegateImplementation.php";
			
		/**
		 * This is the util factory class for the <xsl:value-of select="@name"/>Delegate.
		 *
		 * @package common
		 * @subpackage delegates
		 * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		 * @version $Revision: 1.1 $ $Date: 2007-10-25 16:09:14 $
		 * @copyright Techdivision GbR
		 * @link http://www.techdivision.com
		 */
		class <xsl:value-of select="$className"/>
		{
			
			/**
			 * Holds the possible delegates types.
			 * @var array
			 */
			protected static $_types = array(
			    "local" =<xsl:text disable-output-escaping="yes">&gt;</xsl:text> "<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_<xsl:value-of select="@name"/>DelegateImplementation", 
				"remote" =<xsl:text disable-output-escaping="yes">&gt;</xsl:text> "<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_<xsl:value-of select="@name"/>DelegateRemoteImplementation",
				"dummy" =<xsl:text disable-output-escaping="yes">&gt;</xsl:text> "<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_Delegates_Dummy<xsl:value-of select="@name"/>DelegateImplementation"
			);
			
			/**
			 * Holds the home of the delegate
		 	 * @var <xsl:value-of select="@name"/>Delegate
			 */
			protected static $_delegate = null;
			
			/**
			 * Returns the delegate.
			 *
			 * @param TDProject_Application $application The application instance
		 	 * @return <xsl:value-of select="@name"/>Delegate Holds the delegate
			 */
			public function getDelegate(TDProject_Application $application)
			{
				// check if already an instance exists
				if (self::$_delegate == null) { 
				    // if not load properties and create a new one
					$properties = new TechDivision_Properties_Properties();
					$properties-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>load("<xsl:value-of select="$namespace"/>/WEB-INF/delegate.properties");
					// create a new delegate instance
					self::$_delegate = TechDivision_Util_Object_Factory::get()
					   -<xsl:text disable-output-escaping="yes">&gt;</xsl:text>newInstance(self::$_types[$properties-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get('delegate')], array($application));
				}
				// return the instance
				return self::$_delegate;
			}
		}			
    </xsl:template>
</xsl:stylesheet>