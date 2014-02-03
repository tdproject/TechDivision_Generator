<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output indent="yes" encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Homes_<xsl:value-of select="@name"/>LocalHome</xsl:variable>
		<xsl:variable name="collectionClassName"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Entities_<xsl:value-of select="@name"/>_Collection</xsl:variable>

		require_once "TechDivision/Collections/ArrayList.php";
		require_once "TechDivision/Collections/HashMap.php";
        require_once "TechDivision/Model/Interfaces/LocalHome.php";
		require_once "<xsl:value-of select="$include_path_entities"/><xsl:value-of select="@name"/>.php";
		require_once "<xsl:value-of select="$include_path_homes"/><xsl:value-of select="@name"/>QueryUtil.php";
		require_once "<xsl:value-of select="$include_path_mappings"/><xsl:value-of select="@name"/>Mapping.php";

        /**
         * This class provides methods needed to
         * access the data from the database.
         *
         * @package epb
         * @subpackage homes
         * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
         * @version $Revision: 1.3 $ $Date: 2008-03-04 14:58:01 $
         * @copyright TechDivision GmbH
         * @link http://www.techdivision.com
         */
		class <xsl:value-of select="$className"/> 
		    implements TechDivision_Model_Interfaces_LocalHome
		{
		
			/**
			 * Holds the container instance with the manager.
			 * @var Container
			 */
			protected $_container = null;

            /**
             * Standardconstructor to initialize the
             * database manager used to run the queries
             * against the database.
             *
             * @param TechDivision_Model_Interfaces_Container $container The container instance
             * @return void
             */
			public function __construct(TechDivision_Model_Interfaces_Container $container)
			{
				$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_container = $container;				
			}
			
			/**
			 * This method returns the container.
			 *
			 * @return Container Holds the actual Container instance
			 */
			public function getContainer()
			{
				return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_container;
			}

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_LocalHome::getEntityAlias()
             */
            public function getEntityAlias()
            {
                return '<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Entities_<xsl:value-of select="@name"/>';
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_LocalHome::getMappingAlias()
             */
            public function getMappingAlias()
            {
                return '<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Mappings_<xsl:value-of select="@name"/>Mapping';
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_LocalHome::getCacheTags()
             */
            public function getCacheTags()
            {
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>epbCreate()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getCacheTags();
            }

            /**
             * This method returns a initialized <xsl:value-of select="@name"/> entity.
             *
             * @param mixed $primaryKey Holds the primary key of the entity
             * @return <xsl:value-of select="@name"/> The initialized entity
             */
			public function findByPrimaryKey(TechDivision_Lang_Integer $pk)
			{
				<xsl:variable name="pk" select="/entity/tables/table/keys/pk/@field"/>
				<xsl:variable name="pk-type" select="/entity/members/member[@sqlname=$pk]/@type"></xsl:variable>
                // lookup and return the entity
                return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>lookup($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getEntityAlias(), $pk-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>intValue());
			}

			/**
			 * This method returns a initialized <xsl:value-of select="@name"/> entity.
			 *
			 * @param array $query Holds the query to execute
			 * @param array $params Holds the query parameters
			 * @param boolean $useDedicated Holds the flag to use the dedicated database manager with the name of the following paramater
			 * @param string $dedicatedName Holds the name of the dedicated database manager to use
			 * @return Collection The Collection with the found result
			 * @throws <xsl:value-of select="../../../entity/@name"/>FindException Throws a exception if the passed query is not valid
			 */
			public function executeDynamicQuery($query, $params = array(), $useDedicated = false, $dedicatedName = null)
			{
				// initialize the ArrayList for the return values
				$entitys = new TechDivision_Collections_ArrayList();
				// run the sql statment and check that one or more datasets are given back
				if (!$useDedicated) {
					$resultset = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSlaveManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query($query, $params, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMappingAlias());
				} else {
					$resultset = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getDedicatedManager($dedicatedName)-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query($query, $params, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMappingAlias());
				}
				foreach($resultset as $result) {
					$entity = new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Entities_<xsl:value-of select="/entity/@name"/>();
					$entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>connect($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer());
					$entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>populate($result);
					$entitys-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>add($entity);
				}
				return $entitys;
			}

			/**
			 * This method returns a initialized <xsl:value-of select="@name"/> entity.
			 *
			 * @param array $query Holds the query to execute
			 * @param array $params Holds the query parameters
			 * @param boolean $useDedicated Holds the flag to use the dedicated database manager with the name of the following paramater
			 * @param string $dedicatedName Holds the name of the dedicated database manager to use
			 * @return integer The size of the found database entries
			 * @throws <xsl:value-of select="../../../entity/@name"/>FindException Throws a exception if the passed query is not valid
			 */
			public function executeDynamicCounter($query, $params = array(), $useDedicated = false, $dedicatedName = null)
			{
				// initialize the counter
				$size = 0;
				// run the sql statment and check that one or more datasets are given back
				if(!$useDedicated) {
					$resultset = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSlaveManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query($query, $params);
				} else {
					$resultset = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getDedicatedManager($dedicatedName)-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query($query, $params);
				}
				$result = $resultset[0];
				return $result["size"];
			}

			<xsl:call-template name="querys"><xsl:with-param name="collectionClassName"><xsl:value-of select="$collectionClassName"/></xsl:with-param></xsl:call-template>

			<xsl:if test="@type='entity'">
				/**
				 * This method creates an empty <xsl:value-of select="@name"/> entity and returns it.
				 *
				 * @return <xsl:value-of select="@name"/> Returns an empty <xsl:value-of select="@name"/> entity
				 */
				public function epbCreate()
				{
					// create a new entity and return it
					return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>register($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getEntityAlias());
				}

                /**
                 * This method creates a new <xsl:value-of select="@name"/> object.
                 *
                 * @param <xsl:value-of select="@name"/>LightValue Holds an LightValue object with the data
                 * @return integer Returns the primary key of the new object
                 */
                public function create(<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue $lvo)
                {
                    // create a new entity and insert the dataset
                    $entity = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>epbCreate();
                    <xsl:call-template name="initialize-without-pk"/>
                    $id = $entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>create();
                    $lvo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:value-of select="@name"/>Id($id);
                    return $id;
                }

                /**
                 * This method updates a existing <xsl:value-of select="@name"/> object.
                 *
                 * @param <xsl:value-of select="@name"/>LightValue Holds an LightValue object with the data
                 * @return integer Returns the primary key of the updated object
                 */
                public function update(<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue $lvo)
                {
                    // search the entity and update the dataset
                    $entity = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey(<xsl:call-template name="updateparams"/>);
                    <xsl:call-template name="initialize-without-pk"/>
                    $entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>update();
                }

                /**
                 * This method deletes a existing <xsl:value-of select="@name"/> object.
                 *
                 * @param integer The Id of the object that should be deleted
                 * @return integer Returns the primary key of the updated object
                 */
                public function delete(TechDivision_Lang_Integer $pk)
                {
                    // search the entity and delete the dataset
                    $entity = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey($pk);
                    $entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>delete();
                }
            </xsl:if>		
		}
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
	<xsl:template name="querys">
	
		<xsl:param name="collectionClassName"/>
		
		<xsl:for-each select="querys/query">
			/**
			 * <xsl:value-of select="description"/>
			 *
			 * @return <xsl:value-of select="result-type"/> Holds the <xsl:value-of select="result-type"/>
			 */
			public function <xsl:value-of select="method/@name"/>(<xsl:call-template name="params"/>)
			{
				// load the database manager
				<xsl:choose>
				<xsl:when test="@dedicated">$manager = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getDedicatedManager("<xsl:value-of select="@dedicated"/>");</xsl:when>
				<xsl:otherwise>$manager = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSlaveManager();</xsl:otherwise>
				</xsl:choose>
				// run the sql statment and check that one or more datasets are given back
	    		$params = array(<xsl:for-each select="method/params/param">$<xsl:value-of select="@name"/><xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>);
	    		$paramTypes = array(<xsl:for-each select="method/params/param">"<xsl:value-of select="@type"/>"<xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>);
				<xsl:choose>
				    <xsl:when test="result-type='Storable'">
						// load the mappings
						$mappings = $manager-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query(<xsl:value-of select="/entity/@name"/>QueryUtil::<xsl:value-of select="method/@name"/>, $params, $paramTypes, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMappingAlias());
				        // initialize the entity
				        $entity = null;
			    		foreach ($mappings as $mapping) {
                            return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey($mapping-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey());
			    		}
					</xsl:when>
				    <xsl:when test="result-type='Array'">
						// load the mappings
						$mappings = $manager-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query(<xsl:value-of select="/entity/@name"/>QueryUtil::<xsl:value-of select="method/@name"/>, $params, $paramTypes, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMappingAlias());
				        // initialize the array for the return values
				        $entities = array();
				    	foreach ($mappings as $mapping) {
       				        $entities[] = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey($mapping-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey());
   				        }
			    		// return the resultset
   				        return $entities;
					</xsl:when>
				    <xsl:when test="result-type='ArrayList'">				    
				        // initialize the query
                        $query = $manager-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>prepare(<xsl:value-of select="/entity/@name"/>QueryUtil::<xsl:value-of select="method/@name"/>, $params, $paramTypes);
                        $list = new <xsl:value-of select="$collectionClassName"/>($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer());
                        // connect the Collection to the local home and return the Collection
                        return $list-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>setQuery($query)-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>load();
					</xsl:when>
				    <xsl:when test="result-type='HashMap'">
						// load the mappings
						$mappings = $manager-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query(<xsl:value-of select="/entity/@name"/>QueryUtil::<xsl:value-of select="method/@name"/>, $params, $paramTypes, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMappingAlias());
				        // initialize the HashMap for the return values
				        $entities = new TechDivision_Collections_HashMap();
			    		foreach ($mappings as $mapping) {
       				        $entities-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>add($mapping-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey(), $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey($mapping-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey()));
			            }
			    		// return the resultset
			            return $entities;
					</xsl:when>
				    <xsl:when test="result-type='Integer'">
						// load the mappings
						$mappings = $manager-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query(<xsl:value-of select="/entity/@name"/>QueryUtil::<xsl:value-of select="method/@name"/>, $params, $paramTypes, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMappingAlias());
				    	foreach ($mappings as $value) {
			    			return $value;
			    		}
					</xsl:when>
				    <xsl:otherwise>
				        // initialize the HashMap for the return values
				        $entities = new <xsl:value-of select="result-type"/>();
						// load the mappings
						$mappings = $manager-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query(<xsl:value-of select="/entity/@name"/>QueryUtil::<xsl:value-of select="method/@name"/>, $params, $paramTypes, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMappingAlias());
                        // count the found rows first
                        $countRows = $manager-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query('SELECT FOUND_ROWS() AS size');
                        // set the counter
                        foreach ($countRows as $row) {
                            $entities-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>setTotalRecords(
                                (int) $row-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>size
                            );
                        }
			    		// iterate over the mappings and prepare the result
			    		foreach ($mappings as $mapping) {
       				        $entities-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>add($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey($mapping-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey()));
			            }
			    		// return the resultset
			            return $entities;
					</xsl:otherwise>
			    </xsl:choose>
			}
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="params">
		<xsl:choose>
			<xsl:when test="method/params/param">
				<xsl:for-each select="method/params/param">
	                <xsl:choose>
					    <xsl:when test="position()=last()">
					        <xsl:call-template name="param"><xsl:with-param name="name" select="@type"/></xsl:call-template>$<xsl:value-of select="@name"/>
	                    </xsl:when>
	                    <xsl:otherwise>
					        <xsl:call-template name="param"><xsl:with-param name="name" select="@type"/></xsl:call-template>$<xsl:value-of select="@name"/>,
	                    </xsl:otherwise>
	                </xsl:choose>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="updateparams">
		<xsl:for-each select="/entity/tables/table/keys/pk">
			<xsl:variable name="sqlname" select="@field"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					$lvo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:call-template name="capitalize"><xsl:with-param name="text" select="/entity/members/member[@sqlname=$sqlname]/@name"/></xsl:call-template>()
				</xsl:when>
				<xsl:otherwise>
					$lvo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:call-template name="capitalize"><xsl:with-param name="text" select="/entity/members/member[@sqlname=$sqlname]/@name"/></xsl:call-template>()
					<xsl:text disable-output-escaping="yes">, </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="initialize">
		<xsl:for-each select="/entity/tables/table/fields/field">
            <xsl:variable name="sqlname" select="@name"/>
			<xsl:choose>
                <xsl:when test="@type = 'nchar' or @type = 'nvarchar' or @type = 'ntext'">
                    <!--
                     | Muss noch überarbeitet werden, da nicht die richtigen
                     | Setter des Storables verwendet werden
                     -->
                    $entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:call-template name="capitalize">
                        <xsl:with-param name="text" select="/entity/members/member[@sqlname=$sqlname]/@name"/>
                    </xsl:call-template>(utf8_decode($data["<xsl:value-of select="@name"/>"]));
                </xsl:when>
                <xsl:otherwise>
                    <!--
                     | Muss noch überarbeitet werden, da nicht die richtigen
                     | Setter des Storables verwendet werden
                     -->
                    $entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:call-template name="capitalize">
                        <xsl:with-param name="text" select="/entity/members/member[@sqlname=$sqlname]/@name"/>
                    </xsl:call-template>($data["<xsl:value-of select="@name"/>"]);
                </xsl:otherwise>
            </xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="initialize-without-pk">
		<xsl:for-each select="/entity/tables/table/fields/field">
			<xsl:variable name="sqlname" select="@name"/>
			<xsl:choose>
				<xsl:when test="count(/entity/tables/table/keys/pk[@field=$sqlname]) = '0'">
					<!--
					 | Muss noch überarbeitet werden, da nicht die richtigen
					 | Setter des Storables verwendet werden
					 -->
					$entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:call-template name="capitalize"><xsl:with-param name="text" select="/entity/members/member[@sqlname=$sqlname]/@name"/></xsl:call-template>($lvo-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:call-template name="capitalize"><xsl:with-param name="text" select="/entity/members/member[@sqlname=$sqlname]/@name"/></xsl:call-template>());
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="keys">
		<xsl:for-each select="/entity/tables/table/keys/pk">
			<xsl:value-of select="@field"/>
		</xsl:for-each>
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
	
</xsl:stylesheet>