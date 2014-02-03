<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
							  
	<xsl:output encoding="UTF-8" method="text"/>	

	<xsl:include href="../Utils/Utils.xsl"/>
	
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Mappings_<xsl:value-of select="@name"/>Mapping</xsl:variable>
		
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
			implements TechDivision_Model_Interfaces_LightValue {
			
			public function getPrimaryKey()
			{<xsl:for-each select="/entity/tables/table/keys/pk">
			<xsl:variable name="sqlname" select="@field"/>
				return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="php:function('ucfirst', string(/entity/members/member[@sqlname=$sqlname]/@name))"/>();
			}</xsl:for-each>
			
			<xsl:call-template name="methods"/>
		}
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
	
	<xsl:template name="methods">
		<xsl:for-each select="members/member">
			/**
			 * Returns the value of the class member <xsl:value-of select="@name"/>.
			 *
			 * @return <xsl:value-of select="@type"/> Holds the value of the class member <xsl:value-of select="@name"/>
			 */
			public function get<xsl:call-template name="capitalize"><xsl:with-param name="text" select="@name"/></xsl:call-template>() {
				<xsl:call-template name="create-type"><xsl:with-param name="name" select="@type"/><xsl:with-param name="value" select="@sqlname"/><xsl:with-param name="initial" select="@initial"/></xsl:call-template>
			}
		</xsl:for-each>
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
		<xsl:param name="value"/>
		<xsl:param name="initial"/>
		<xsl:choose>
			<xsl:when test="$name='String'">return new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="$value"/>);</xsl:when>
			<xsl:when test="$name='Integer'">
				$string = new TechDivision_Lang_String($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="$value"/>);
				if ($string-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>length() === 0) {
					<xsl:choose>
						<xsl:when test="$initial='null'">return;</xsl:when>
						<xsl:otherwise>return new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>(<xsl:value-of select="$initial"/>);</xsl:otherwise>
					</xsl:choose>
				} else {
					return <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>::valueOf($string);
				}
			</xsl:when>
			<xsl:when test="$name='Float'">
				$string = new TechDivision_Lang_String($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="$value"/>);
				if ($string-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>length() === 0) {
					<xsl:choose>
						<xsl:when test="$initial='null'">return;</xsl:when>
						<xsl:otherwise>return new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>(<xsl:value-of select="$initial"/>);</xsl:otherwise>
					</xsl:choose>
				} else {
					return <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>::valueOf($string);
				}
			</xsl:when>
			<xsl:when test="$name='Boolean'">
				$string = new TechDivision_Lang_String($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="$value"/>);
				if ($string-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>length() === 0) {
					<xsl:choose>
						<xsl:when test="$initial='null'">return;</xsl:when>
						<xsl:otherwise>return new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>(<xsl:value-of select="$initial"/>);</xsl:otherwise>
					</xsl:choose>
				} else {
					return <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>::valueOf($string);
				}
			</xsl:when>
			<xsl:otherwise>return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="$value"/>;</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		
</xsl:stylesheet>