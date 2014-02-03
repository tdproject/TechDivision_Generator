<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output indent="yes" encoding="UTF-8" method="html"/>
	<xsl:param name="template_path"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:template match="processor">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Services_Abstract<xsl:value-of select="@name"/></xsl:variable>
		
		require_once "TechDivision/Model/Container/Implementation.php";
		require_once "TechDivision/Model/Interfaces/Exception.php";
		require_once "TechDivision/Model/Interfaces/Session.php";		
		require_once "TechDivision/Model/Manager/Transaction.php";
		
        /**
	     * <xsl:value-of select="description"/>
         * 
         * @category <xsl:value-of select="$namespace"/>
         * @package <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>
         * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
         * @version $Revision: 1.1 $ $Date: 2007-10-25 16:09:14 $
         * @copyright TechDivision GmbH
         * @link http://www.techdivision.com 
         */
		abstract class <xsl:value-of select="$className"/> 
			extends TechDivision_Model_Manager_Transaction 
			implements TechDivision_Model_Interfaces_Session 
		{
            /**
             * Holds the container instance with the manager.
             * @var TechDivision_Model_Interfaces_Container
             */
            protected $_container = null;

		    /**
		     * Holds the id of the current session.
		     *
		     * @var string The id of the currently active session
		     */
		    protected $_sessionId = null;
		
			/**
			 * @see TechDivision_Model_Interfaces_Bean::getClass()
			 */
			public function getClass()
			{
				return get_class($this);
			}
			
			/**
			 * Disconnects the bean from the referenced container.
			 * 
			 * @return void
			 */
			public function __destruct()
			{
			     // disconnect from the container
			     $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>disconnect();
			}

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Bean::connect()
             */
            public function connect(
                TechDivision_Model_Interfaces_Container $container)
            {
                $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_container = $container;
                $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_sessionId = $container-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSessionId();
                return $this;
            }

		    /**
		     * (non-PHPdoc)
		     * @see TechDivision_Model_Interfaces_Bean::disconnect()
		     */
			public function disconnect()
			{
			    $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_container = null;
			    return $this;
			}

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Bean::getContainer()
             */
            public function getContainer()
            {
				return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_container;
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Session::getSessionId()
             */
            public function getSessionId()
            {
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_sessionId;
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Bean::getPrimaryKey()
             */
            public function getPrimaryKey()
            {
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSessionId();
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Bean::getCacheKey()
             */
            public function getCacheKey()
            {
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey();
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Bean::getCacheTags()
             */
            public function getCacheTags()
            {
                return array(strtolower(__CLASS__));
            }
            
            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Session::load()
             */
            public function load($sessionId)  
            {
                return $this;
            }
            
            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Container_Implementation::newInstance()
             */
		    public function newInstance($className, array $arguments = array())
		    {
		    	return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>newInstance($className, $arguments);
		    }
					
			<xsl:for-each select="methods/method">
		   	/**
			 * <xsl:value-of select="description"/>
			 * <xsl:for-each select="params/param">
			 * @param <xsl:value-of select="@type"/> $<xsl:value-of select="@name"/><xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="description"/></xsl:for-each>
			 * @return <xsl:value-of select="return/@type"/><xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select="return/description"/>
			 */ 
			public <xsl:value-of select="@type"/> function <xsl:value-of select="@name"/>(<xsl:for-each select="params/param"><xsl:if test="@type!='string' and @type!='integer' and @type!='double' and @type!='float' and @type!='boolean' and @type!='array'"><xsl:value-of select="@type"/><xsl:text disable-output-escaping="yes"> </xsl:text></xsl:if>$<xsl:value-of select="@name"/><xsl:if test="@default"> = <xsl:value-of select="@default"/></xsl:if><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>);					
			</xsl:for-each>
	    }
		
	    <xsl:text disable-output-escaping="yes">?&gt;</xsl:text>			
    </xsl:template>
</xsl:stylesheet>