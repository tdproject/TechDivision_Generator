<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
							  
	<xsl:output encoding="UTF-8" method="text"/>
	
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue</xsl:variable>
		
		require_once 'TechDivision/Lang/Object.php';
		require_once 'TechDivision/Model/Interfaces/LightValue.php';
		
		/**
		 * This class is the data transfer object between the
		 * model and the controller for the table <xsl:value-of select="//entity/tables/table/@name"/>.
		 *
		 * Each class member reflects a database field and
		 * the values of the related dataset.
		 *
		 * @package common
		 * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		 * @version $Revision: 1.2 $ $Date: 2007-12-06 15:39:17 $
		 * @copyright TechDivision GmbH
		 * @link http://www.techdivision.com
		 */		
		class <xsl:value-of select="$className"/> 
			extends TechDivision_Lang_Object
			implements TechDivision_Model_Interfaces_LightValue
		{
			
		<xsl:for-each select="members/member">		
			protected $<xsl:value-of select="@name"/>;
		</xsl:for-each>
		
			/**
			 * The constructor intializes the DTO with the
			 * values passed as parameter.
			 * 
			 * @param array $array Holds the array with the virtual members to pass to the AbstractDTO's constructor
			 * @return void
			 */
			public function __construct(<xsl:value-of select="$className"/> $lvo = null) 
			{
				if(!empty($lvo)) {<xsl:for-each select="members/member">
					$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:value-of select="php:function('ucfirst', string(@name))"/>($lvo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="php:function('ucfirst', string(@name))"/>());</xsl:for-each>
				}
			}
    		<xsl:if test="members/member[@to-string='true']">
		    /**
		     * (non-PHPdoc)
		     * @see TechDivision_Lang_Object::__toString()
		     */
			public function __toString()
			{
				return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="php:function('ucfirst', string(members/member[@to-string='true']/@name))"/>()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>__toString();
			}</xsl:if>
			
			<xsl:call-template name="methods"/>
		}
	</xsl:template>
	
	<xsl:template name="methods">
		<xsl:for-each select="members/member"><xsl:variable name="sqlname" select="@sqlname"/>
			/**
			 * Returns the value of the class member <xsl:value-of select="@name"/>.
			 *
			 * @return <xsl:value-of select="@type"/> Holds the value of the class member <xsl:value-of select="@name"/>
			 */
			public function get<xsl:value-of select="php:function('ucfirst', string(@name))"/>()
			{
				return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="@name"/>;
			}
			
			/**
			 * Sets the value for the class member <xsl:value-of select="@name"/>.
			 *
			 * @param <xsl:value-of select="@type"/> $<xsl:value-of select="@type"/> Holds the value for the class member <xsl:value-of select="@name"/>
			 */
			public function set<xsl:value-of select="php:function('ucfirst', string(@name))"/>(<xsl:call-template name="param"><xsl:with-param name="name" select="@type"/></xsl:call-template>$<xsl:value-of select="@name"/><xsl:if test="/entity/tables/table/fields/field[@name=$sqlname]/@nullable='true'"> = null</xsl:if>)
			{
				$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="@name"/> = $<xsl:value-of select="@name"/>;
			}
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
			<xsl:when test="$name='String'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template></xsl:when>
			<xsl:when test="$name='Integer'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template></xsl:when>
			<xsl:when test="$name='Float'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template></xsl:when>
			<xsl:when test="$name='Boolean'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template></xsl:when>
		</xsl:choose>
	</xsl:template>
		
</xsl:stylesheet>