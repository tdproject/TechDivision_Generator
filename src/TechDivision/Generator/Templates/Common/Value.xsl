<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
							  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
	
	<xsl:output encoding="UTF-8" method="html"/>	

	<xsl:include href="../Utils/Utils.xsl"/>
	
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>Value</xsl:variable>
				
		require_once 'TechDivision/Collections/ArrayList.php';
		require_once 'TechDivision/Model/Interfaces/Value.php';
		require_once '<xsl:value-of select="$include_path_value_objects"/><xsl:value-of select="@name"/>LightValue.php';
		<xsl:call-template name="include-references"/>
		
		/**
		 * This class is the data transfer object between the
		 * model and the controller for the table <xsl:value-of select="//entity/tables/table/@name"/>.
		 *
		 * Each class member reflects a database field and
		 * the values of the related dataset.
		 *
		 * @package Common
		 * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		 * @version $Revision: 1.1 $ $Date: 2007-10-25 16:09:14 $
		 * @copyright TechDivision GmbH
		 * @link http://www.techdivision.com
		 */			
		class <xsl:value-of select="$className"/> 
			extends <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue
			implements TechDivision_Model_Interfaces_Value  {
			
		<xsl:for-each select="references/reference">		
			protected $<xsl:value-of select="php:function('lcfirst', string(method-name))"/>;
		</xsl:for-each>
		
			/**
			 * The constructor intializes the DTO with the
			 * values passed as parameter.
			 * 
			 * @param array $array Holds the array with the virtual members to pass to the AbstractDTO's constructor
			 * @return void
			 */
			public function __construct(<xsl:value-of select="$className"/> $vo = null) {
				// call the parents constructor
				parent::__construct($vo);
				// initialize the ValueObject with the passed data
				if (!empty($vo)) {
					<xsl:for-each select="references/reference">
						<xsl:choose>
							<xsl:when test="multiplicity='many' or multiplicity='many-to-many'">
							$list = new TechDivision_Collections_ArrayList();
							foreach ($vo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="method-name"/>() as $dto) {
								$list-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>add($dto-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getLightValue());
							}
							$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:value-of select="method-name"/>($list);
							</xsl:when>
							<xsl:when test="multiplicity='one'">
							if (($related = $vo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="method-name"/>()) != null) {
								$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:value-of select="method-name"/>($related-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getLightValue());
							}
							</xsl:when>
						</xsl:choose>
					</xsl:for-each>}
			}
			
			<xsl:call-template name="references"/>
			
			/**
			 * This method returns the LightValue
			 * version of this Value object.
			 * 
			 * @return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue 
			 *  	The initialized LightValue
			 */
			public function getLightValue() {
				return new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue($this);
			}
		}
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
	
	<xsl:template name="params">
		<xsl:for-each select="members/member">
			<xsl:choose>
				<xsl:when test="position()=last()">
					$<xsl:value-of select="@name"/> = null
				</xsl:when>
				<xsl:otherwise>
					$<xsl:value-of select="@name"/><xsl:text disable-output-escaping="yes"> = null, </xsl:text>					
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="referencepopulate">
		<xsl:for-each select="references/reference">
			<xsl:choose>
				<xsl:when test="multiplicity='many' or multiplicity='many-to-many'">			
					$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:call-template name="str:to-camelcase"><xsl:with-param name="text" select="method-name"/><xsl:with-param name="upper" select="false()"/></xsl:call-template>s = $vo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:call-template name="str:to-camelcase"><xsl:with-param name="text" select="method-name"/><xsl:with-param name="upper" select="false()"/></xsl:call-template>s;					
				</xsl:when>
				<xsl:otherwise>
					$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:call-template name="str:to-camelcase"><xsl:with-param name="text" select="method-name"/><xsl:with-param name="upper" select="false()"/></xsl:call-template> = $vo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:call-template name="str:to-camelcase"><xsl:with-param name="text" select="method-name"/><xsl:with-param name="upper" select="false()"/></xsl:call-template>;					
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
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
			public function set<xsl:value-of select="method-name"/>(TechDivision_Collections_Interfaces_Collection $collection = null) {
                $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="php:function('lcfirst', string(method-name))"/> = $collection;
			}

			/**
			 * Returns the
			 *
			 * @return TechDivision_Collections_Interfaces_Collection Holds the
			 */
			public function get<xsl:value-of select="method-name"/>() {
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="php:function('lcfirst', string(method-name))"/>;
			}
				</xsl:when>
				<xsl:when test="multiplicity='one'">
			/**
			 * Sets the
			 *
			 * @param <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="source/entity-name"/>LightValue Holds the
			 */
			public function set<xsl:value-of select="method-name"/>(<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="source/entity-name"/>LightValue $lvo = null) {
                $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="php:function('lcfirst', string(method-name))"/> = $lvo;
			}

			/**
			 * Returns the
			 *
			 * @return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="source/entity-name"/>LightValue Holds the
			 */
			public function get<xsl:value-of select="method-name"/>() {
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="php:function('lcfirst', string(method-name))"/>;   
			}
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>	

	<!--  -->
	<xsl:template name="include-references">
		<xsl:for-each select="/entity/references/reference">
            <!--
			 | The variable $include_path_ ... is the ouput path
			 | of the plugin configuration
			 -->
			require_once "<xsl:value-of select="$include_path_value_objects"/><xsl:value-of select="source/entity-name"/>LightValue.php";
		</xsl:for-each>
	</xsl:template>
		
</xsl:stylesheet>