<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">

	<xsl:output encoding="UTF-8" method="html"/>

	<xsl:include href="../Utils/Utils.xsl"/>

	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>

        // necessary includes
		require_once "collections/hashmap.php";
		require_once "<xsl:value-of select="$include_path_utils"/><xsl:call-template name="str:to-lower"><xsl:with-param name="text" select="@name"/></xsl:call-template>util.php";
        <xsl:call-template name="includes"/>

		class <xsl:value-of select="@name"/>VOAssembler {

			private $home = null;
			private $cache = null;

			public function __construct() {
				$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>home = <xsl:value-of select="@name"/>Util::getHome();
			}

			/**
			 * This method saves the passed collection under the
			 * also passed signature in the internal cache.
			 *
			 * @param string $signature Holds the unique message signature
			 * @return void
			 */
			public function setCacheResult($signature, $collection) {
				$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>cache-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>add($signature, $collection);
			}

            /**
             * This method returns a initialized value object.
             *
             * @param array $primaryKey Holds the primary key of the value object
             * @return <xsl:value-of select="@name"/>Value The initialized value object
             */
            public function findByPrimaryKey($primaryKey) {
            	return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>home-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey($primaryKey)-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="@name"/>Value();
            }

			/**
			 * This is the default method to transform a Collection
			 * with entitys into an ArrayList.
			 *
			 * @param Collection $entitys Holds the Collection with entitys to transform
			 * @return Collection Holds the transformed Collection with Values
			 * @deprecated This method is deprecated, use the specialized versions instead
			 */
			public function getValueObjects($entitys) {
				return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getValueObjectsAsArrayList($entitys);
			}

			public function getValueObjectsAsArrayList($entitys) {
				// initialize a new ArrayList
				$vos = new ArrayList();
				foreach($entitys as $entity) {
					$vos-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>add($entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="/entity/@name"/>Value());
				}
				return $vos;
			}

			public function getValueObjectsAsArray($entitys) {
				// initialize a new array
				$vos = array();
				foreach($entitys as $entity) {
					$vos[$entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey()] = $entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="/entity/@name"/>Value();
				}
				return $vos;
			}

			public function getValueObjectsAsHashMap($entitys) {
				// initialize a new HashMap
				$vos = new HashMap();
				foreach($entitys as $entity) {
					$vos-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>add($entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey(), $entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="/entity/@name"/>Value());
				}
				return $vos;
			}

			<xsl:call-template name="querys"/>

		}
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>

	<xsl:template name="querys">
		<xsl:for-each select="querys/query">
				<xsl:choose>
					<xsl:when test="result-type='Storable'">
                        /**
                         * <xsl:value-of select="description"/>
                         *
                         * @return <xsl:value-of select="result-type"/> Holds the <xsl:value-of select="result-type"/>
                         */
                        public function <xsl:value-of select="method/@name"/>(<xsl:call-template name="params"/>) {
                            return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>home-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="method/@name"/>(<xsl:call-template name="params"/>)-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="../../../entity/@name"/>Value();
                        }
					</xsl:when>
					<xsl:when test="result-type='Array'">
                        /**
                         * <xsl:value-of select="description"/>
                         *
                         * @return <xsl:value-of select="result-type"/> Holds the <xsl:value-of select="result-type"/>
                         */
                        public function <xsl:value-of select="method/@name"/>(<xsl:call-template name="finder-params"/>) {
                        	$entitys = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>home-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="method/@name"/>(<xsl:call-template name="params"/>);
                            return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getValueObjectsAsArray($entitys);
                        }
					</xsl:when>
					<xsl:when test="result-type='ArrayList'">
                        /**
                         * <xsl:value-of select="description"/>
                         *
                         * @return <xsl:value-of select="result-type"/> Holds the <xsl:value-of select="result-type"/>
                         */
                        public function <xsl:value-of select="method/@name"/>(<xsl:call-template name="finder-params"/>) {
                        	$entitys = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>home-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="method/@name"/>(<xsl:call-template name="params"/>);
                            return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getValueObjectsAsArrayList($entitys);
                        }
					</xsl:when>
					<xsl:when test="result-type='HashMap'">
                        /**
                         * <xsl:value-of select="description"/>
                         *
                         * @return <xsl:value-of select="result-type"/> Holds the <xsl:value-of select="result-type"/>
                         */
                        public function <xsl:value-of select="method/@name"/>(<xsl:call-template name="finder-params"/>) {
                        	$entitys = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>home-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="method/@name"/>(<xsl:call-template name="params"/>);
                            return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getValueObjectsAsHashMap($entitys);
                        }
					</xsl:when>
				</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="finder-params">
		<xsl:choose>
			<xsl:when test="method/params/param">
				<xsl:for-each select="method/params/param">
	                <xsl:choose>
					    <xsl:when test="position()=last()">
					        <xsl:text disable-output-escaping="yes"> </xsl:text>$<xsl:value-of select="@name"/>
	                    </xsl:when>
	                    <xsl:otherwise>
					        <xsl:text disable-output-escaping="yes"> </xsl:text>$<xsl:value-of select="@name"/>,
	                    </xsl:otherwise>
	                </xsl:choose>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="params">
		<xsl:choose>
			<xsl:when test="method/params/param">
				<xsl:for-each select="method/params/param">
                	<xsl:choose>
				    	<xsl:when test="position()=last()">
				        	<xsl:text disable-output-escaping="yes"> </xsl:text>$<xsl:value-of select="@name"/>
                    	</xsl:when>
                    	<xsl:otherwise>
				        	<xsl:text disable-output-escaping="yes"> </xsl:text>$<xsl:value-of select="@name"/>,
                    	</xsl:otherwise>
                	</xsl:choose>
				</xsl:for-each>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="initialize">
		<xsl:for-each select="../../tables/table/fields/field">
			$entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:call-template name="capitalize"><xsl:with-param name="text" select="@name"/></xsl:call-template>($data["<xsl:value-of select="@name"/>"]);
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="includes">
		<xsl:for-each select="/entity/references/reference">
			require_once "<xsl:value-of select="$include_path_utils"/><xsl:call-template name="str:to-lower"><xsl:with-param name="text" select="source/entity-name"/></xsl:call-template>util.php";
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>