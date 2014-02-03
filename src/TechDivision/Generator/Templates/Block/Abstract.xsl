<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
							  
	<xsl:output encoding="UTF-8" method="text"/>
	
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Block_Abstract_<xsl:value-of select="@name"/></xsl:variable>
		<xsl:variable name="classNameVO"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>Value</xsl:variable>
		<xsl:variable name="classNameLVO"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue</xsl:variable>
		
		require_once 'TechDivision/Lang/String.php';
		require_once 'TechDivision/Lang/Integer.php';
		require_once 'TechDivision/Lang/Float.php';
		require_once 'TechDivision/Lang/Boolean.php';
		require_once 'TechDivision/Collections/Interfaces/Collection.php';
		require_once 'TDProject/Core/Block/Abstract.php';
		require_once 'TDProject/Core/Block/Widget/Form/Abstract/View.php';
		require_once '<xsl:value-of select="$include_path_value_objects"/><xsl:value-of select="@name"/>Value.php';
		
		/**
		 * This class is the data transfer object between the
		 * model and the controller for the table <xsl:value-of select="//entity/tables/table/@name"/>.
		 *
		 * Each class member reflects a database field and
		 * the values of the related dataset.
		 *
		 * @package common
		 * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		 * @version $Revision: 1.0 $ $Date: 2007-12-06 15:39:17 $
		 * @copyright TechDivision GmbH
		 * @link http://www.techdivision.com
		 */		
		abstract class <xsl:value-of select="$className"/> 
			extends  TDProject_Core_Block_Widget_Form_Abstract_View {
			
		<xsl:for-each select="members/member">
			/**
			 * @var <xsl:call-template name="type"><xsl:with-param name="name" select="@type"></xsl:with-param></xsl:call-template>
			 */
			protected $_<xsl:value-of select="@name"/> = null;
		</xsl:for-each>
			
		<xsl:for-each select="references/reference">
			/**
			 * @var <xsl:choose><xsl:when test="multiplicity='many' or multiplicity='many-to-many'">TechDivision_Collections_Interfaces_Collection</xsl:when><xsl:otherwise><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="source/entity-name"/>LightValue</xsl:otherwise></xsl:choose>
			 */	
			protected $_<xsl:value-of select="php:function('lcfirst', string(method-name))"/> = null;
		</xsl:for-each>

			/**
		     * (non-PHPdoc)
		     * @see TDProject/Interfaces/Block#prepareLayout()
		     */
		    public function prepareLayout()
		    {
		    	// add the hidden fields<xsl:for-each select="members/member"><xsl:variable name="sqlname" select="@sqlname"/>
				<xsl:if test="/entity/tables/table/keys/pk[@field=$sqlname]">
				$this->addElement($this->getElement('hidden', '<xsl:value-of select="@name"/>'));</xsl:if></xsl:for-each>
				// return the instance
		    	return parent::prepareLayout();
		    }
    
		    /**
		     * (non-PHPdoc)
		     * @see TDProject_Core_Interfaces_Block_Widget_Form_View::getDeleteUrl()
		     */
		    public function getDeleteUrl() 
		    {<xsl:for-each select="members/member"><xsl:variable name="sqlname" select="@sqlname"/>
				<xsl:if test="/entity/tables/table/keys/pk[@field=$sqlname]">
		    	return '?path=' . $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPath() . '&amp;method=delete&amp;<xsl:value-of select="@name"/>=' . $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="php:function('ucfirst', string(@name))"/>();</xsl:if></xsl:for-each>
		    }
			<xsl:call-template name="methods"/>
			
			<xsl:call-template name="references"/>
    
		    /**
		     * (non-PHPdoc)
		     * @see TDProject_Core_Block_Abstract::reset()
		     */
			public function reset() 
			{<xsl:for-each select="members/member">		
				$this->_<xsl:value-of select="@name"/> = <xsl:call-template name="create-type"><xsl:with-param name="name" select="@type"/></xsl:call-template>;</xsl:for-each><xsl:for-each select="references/reference">		
				$this->_<xsl:value-of select="php:function('lcfirst', string(method-name))"/> = <xsl:choose><xsl:when test="multiplicity='many' or multiplicity='many-to-many'">new TechDivision_Collections_ArrayList</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose>;</xsl:for-each>
			}
			
			/**
			 * Populates the form with the data of the
			 * passed LVO.
			 *
			 * @param <xsl:value-of select="$classNameLVO"/> $lvo
			 * 		The LVO to populate the form with
			 * @return <xsl:value-of select="$className"/>
			 * 		The instance itself
			 */
			public function populate(<xsl:value-of select="$classNameVO"/> $vo)
			{<xsl:for-each select="members/member">		
				$this->_<xsl:value-of select="@name"/> = $vo->get<xsl:value-of select="php:function('ucfirst', string(@name))"/>();</xsl:for-each><xsl:for-each select="references/reference">		
				$this->_<xsl:value-of select="php:function('lcfirst', string(method-name))"/> = $vo->get<xsl:value-of select="method-name"/>();</xsl:for-each>
				return $this;
			}
			
			/**
			 * Initializes a new LVO with the data from
			 * the form and returns it.
			 *
			 * @return <xsl:value-of select="$classNameLVO"/>
			 * 		The LVO initialized with the data of the form
			 */
			public function repopulate()
			{
				$lvo = new <xsl:value-of select="$classNameLVO"/>();<xsl:for-each select="members/member">		
				$lvo->set<xsl:value-of select="php:function('ucfirst', string(@name))"/>($this->get<xsl:value-of select="php:function('ucfirst', string(@name))"/>());</xsl:for-each>
				return $lvo;
			}
		}
		
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
		
	</xsl:template>
	
	<xsl:template name="methods">
		<xsl:for-each select="members/member"><xsl:variable name="sqlname" select="@sqlname"/>
			/**
			 * Returns the value of the class member <xsl:value-of select="@name"/>.
			 *
			 * @return <xsl:call-template name="type"><xsl:with-param name="name" select="@type"></xsl:with-param></xsl:call-template> Holds the value of the class member <xsl:value-of select="@name"/>
			 */
			public function get<xsl:value-of select="php:function('ucfirst', string(@name))"/>()
			{
				return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_<xsl:value-of select="@name"/>;
			}
			
			/**
			 * Sets the value for the class member <xsl:value-of select="@name"/>.
			 *
			 * @param string $string Holds the value for the class member <xsl:value-of select="@name"/>
			 */
			public function set<xsl:value-of select="php:function('ucfirst', string(@name))"/>($string) {<xsl:choose>
				<xsl:when test="@type='String'">
					$this-<xsl:text disable-output-escaping="yes">&gt;_</xsl:text><xsl:value-of select="@name"/> = new TechDivision_Lang_String($string);
				</xsl:when>
				<xsl:when test="@type='Integer'">
					$this-<xsl:text disable-output-escaping="yes">&gt;_</xsl:text><xsl:value-of select="@name"/> = TechDivision_Lang_Integer::valueOf(new TechDivision_Lang_String($string));
				</xsl:when>
				<xsl:when test="@type='Boolean'">
					$this-<xsl:text disable-output-escaping="yes">&gt;_</xsl:text><xsl:value-of select="@name"/> = TechDivision_Lang_Boolean::valueOf(new TechDivision_Lang_String($string));
				</xsl:when>
				<xsl:when test="@type='Float'">
					$this-<xsl:text disable-output-escaping="yes">&gt;_</xsl:text><xsl:value-of select="@name"/> = TechDivision_Lang_Float::valueOf(new TechDivision_Lang_String($string));
				</xsl:when>
				<xsl:otherwise>
					$this-<xsl:text disable-output-escaping="yes">&gt;_</xsl:text><xsl:value-of select="@name"/> = $string;
				</xsl:otherwise>
			</xsl:choose>}
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="types">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="../../fields/field[$name]/@type='varchar'">'{$lvo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:call-template name="capitalize"><xsl:with-param name="text" select="$name"/></xsl:call-template>()}'</xsl:when>
			<xsl:when test="../../fields/field[$name]/@type='integer'">{$lvo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:call-template name="capitalize"><xsl:with-param name="text" select="$name"/></xsl:call-template>()}</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="param">
		<xsl:param name="name"/>
		<xsl:variable name="type">
			<xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>
		</xsl:variable>
		<xsl:if test="$type"><xsl:value-of select="$type"/><![CDATA[ ]]></xsl:if>
	</xsl:template>
	
	<xsl:template name="type">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$name='String'">TechDivision_Lang_String</xsl:when>
			<xsl:when test="$name='Integer'">TechDivision_Lang_Integer</xsl:when>
			<xsl:when test="$name='Float'">TechDivision_Lang_Float</xsl:when>
			<xsl:when test="$name='Boolean'">TechDivision_Lang_Boolean</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="create-type">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$name='String'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>()</xsl:when>
			<xsl:when test="$name='Integer'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>(0)</xsl:when>
			<xsl:when test="$name='Float'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>(0.00)</xsl:when>
			<xsl:when test="$name='Boolean'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>(false)</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="references">
		<xsl:for-each select="references/reference">
			<xsl:choose>
				<xsl:when test="multiplicity='many' or multiplicity='many-to-many'">
			/**
			 * Sets the
			 *
			 * @param TechDivision_Collections_Interfaces_Collection Holds the
			 */
			public function set<xsl:value-of select="method-name"/>(TechDivision_Collections_Interfaces_Collection $collection)
			{
                $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_<xsl:value-of select="php:function('lcfirst', string(method-name))"/> = $collection;
			}

			/**
			 * Returns the
			 *
			 * @return TechDivision_Collections_Interfaces_Collection Holds the
			 */
			public function get<xsl:value-of select="method-name"/>()
			{
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_<xsl:value-of select="php:function('lcfirst', string(method-name))"/>;
			}
				</xsl:when>
				<xsl:when test="multiplicity='one'">
			/**
			 * Sets the
			 *
			 * @param <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="source/entity-name"/>LightValue Holds the
			 */
			public function set<xsl:value-of select="method-name"/>(<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="source/entity-name"/>LightValue $lvo)
			{
                $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_<xsl:value-of select="php:function('lcfirst', string(method-name))"/> = $lvo;
			}

			/**
			 * Returns the 
			 *
			 * @return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="source/entity-name"/>LightValue Holds the
			 */
			public function get<xsl:value-of select="method-name"/>()
			{
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_<xsl:value-of select="php:function('lcfirst', string(method-name))"/>;   
			}
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
		
</xsl:stylesheet>