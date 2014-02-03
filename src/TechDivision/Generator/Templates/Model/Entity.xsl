<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
	
	<xsl:output encoding="UTF-8" method="html"/>
	
	<xsl:include href="../Utils/Utils.xsl"/>
	
	<xsl:param name="include_path_value_objects"/>
	<xsl:param name="include_path_exceptions"/>
	<xsl:param name="include_path_utils"/>
	
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Entities_<xsl:value-of select="@name"/></xsl:variable>
		require_once "TechDivision/Collections/ArrayList.php";
		require_once "TechDivision/Model/Interfaces/Entity.php";
		require_once "<xsl:value-of select="$include_path_value_objects"/><xsl:value-of select="@name"/>LightValue.php";
		require_once "<xsl:value-of select="$include_path_value_objects"/><xsl:value-of select="@name"/>Value.php";
		require_once "<xsl:value-of select="$include_path_exceptions"/><xsl:value-of select="@name"/>CountException.php";
		require_once "<xsl:value-of select="$include_path_exceptions"/><xsl:value-of select="@name"/>CreateException.php";
		require_once "<xsl:value-of select="$include_path_exceptions"/><xsl:value-of select="@name"/>DeleteException.php";
		require_once "<xsl:value-of select="$include_path_exceptions"/><xsl:value-of select="@name"/>FindException.php";
		require_once "<xsl:value-of select="$include_path_exceptions"/><xsl:value-of select="@name"/>UpdateException.php";
		require_once "<xsl:value-of select="$include_path_mappings"/><xsl:value-of select="@name"/>Mapping.php";
        <xsl:if test="@type='entity'">
        <xsl:for-each select="/entity/tables/table/keys/pk">
        <xsl:variable name="sqlname" select="@field"/>
        <xsl:if test="/entity/tables/table/fields/field[@name=$sqlname]/@autoincrement='false'">
        require_once "<xsl:value-of select="$include_path_exceptions"/>SequenceBlockException.php";
        require_once "<xsl:value-of select="$include_path_utils"/>SequenceBlockUtil.php";</xsl:if></xsl:for-each></xsl:if>
		<xsl:call-template name="include-references"/>
		<xsl:call-template name="include-interfaces"/>

        /**
         * <xsl:value-of select="description"/>
         *
         * @package Model
         * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
         * @version $Revision: 1.2 $ $Date: 2008-03-04 14:58:01 $
         * @copyright TechDivision GmbH
         * @link http://www.techdivision.com
         */
		class <xsl:value-of select="$className"/> 
			extends <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>Value 
			implements TechDivision_Model_Interfaces_Entity<xsl:for-each select="interfaces/interface">, <xsl:value-of select="@name"/></xsl:for-each> {

            /**
             * Holds the container instance with the manager.
             * @var TechDivision_Model_Interfaces_Container
             */
            protected $_container = null;
            
            /**
             * Holds the table name for creating dynamic queries.
             * @var string
             */
            const TABLE = "<xsl:for-each select="//entity/tables/table"><xsl:value-of select="@name"/></xsl:for-each>";
            
            /**
             * Holds the table name for creating dynamic queries.
             * @var string
             */
            const FIELDS = "<xsl:for-each select="//entity/tables/table"><xsl:value-of select="@name"/></xsl:for-each>.*";
 			<xsl:call-template name="constants"/>
			/**
             * Initializes the entity bean.
             * 
             * @return void
             */
			public function __construct() 
			{
				// initialize the default values here<xsl:for-each select="/entity/members/member">
				$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="@name"/> = <xsl:call-template name="new-type"><xsl:with-param name="name" select="@type"/><xsl:with-param name="initial" select="@initial"/></xsl:call-template>;</xsl:for-each>
			}
			
			/**
			 * Disconnects the entiy bean from the referenced container.
			 * 
			 * @return void
			 */
			public function __destruct()
			{
			     // disconnect from the container
			     $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>disconnect();
			}
		
			/**
			 * @see TechDivision_Model_Interfaces_Bean::getClass()
			 */
			public function getClass()
			{
				return get_class($this);
			}

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Bean::connect()
             */
            public function connect(
                TechDivision_Model_Interfaces_Container $container)
            {
                $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>_container = $container;
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
             * @see TechDivision_Model_Interfaces_Entity::getEntityAlias()
             */
            public function getEntityAlias()
            {
                return '<xsl:value-of select="$className"/>';
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Entity::getMappingAlias()
             */
            public function getMappingAlias()
            {
                return '<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Mappings_<xsl:value-of select="@name"/>Mapping';
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Bean::getPrimaryKey()
             */
            public function getPrimaryKey()
            {
                return <xsl:call-template name="entitykeys"/>;
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
                return array(strtolower($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getEntityAlias()));
            }

			<xsl:call-template name="references"/>

			/**
			 * Initializes the entity with the data from the 
			 * <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue object.
			 *
			 * @return void
			 */
			public function populate(<xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Mappings_<xsl:value-of select="@name"/>Mapping $mapping)
			{
				<xsl:call-template name="initialize-with-pk"/>
			}

			/**
			 * Returns the <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue object.
			 * 
			 * @return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue Holds the LightValue object with the data
			 */
			public function getLightValue()
			{
				return new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>LightValue($this);
			}

			/**
			 * Returns the <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>Value object.
			 *
			 * @param boolean $refresh Holds the flag to identified, that the data should be refreshed from the database
			 * @return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>Value Holds the Value object with the data
			 */
			public function getValue() 
			{
				return new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Common_ValueObjects_<xsl:value-of select="@name"/>Value($this);
			}

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Entity::load()
             */
            public function load($pk) 
            {
                try {
                
					$params = array($pk);
					$paramTypes = array('integer');
                    
                    $result = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getSlaveManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>query(<xsl:call-template name="load"/>, $params, $paramTypes, $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMappingAlias());
                    
                    if ($length = sizeof($result) === 1) {
	                    for ($i = 0; $i <xsl:text disable-output-escaping="yes">&lt;</xsl:text> $length; $i++) {
	                    	return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>populate($result[$i]);
	                    }
                    }

                    throw new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Exceptions_<xsl:value-of select="@name"/>FindException("Can't load <xsl:value-of select="@name"/> with id " . var_export($params, true));
                    
                } catch(TechDivision_Model_Interfaces_Exception $tmie)	{
                    // if a exception is thrown
                    throw new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Exceptions_<xsl:value-of select="@name"/>FindException($tmie-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>__toString());
                }
            }
            
		   <xsl:if test="//entity/tables/table/@type='View'">
		   /**
            * (non-PHPdoc)
			* @see TechDivision_Model_Interfaces_Entity::create()
			*/
			public function create() 
			{
				throw new Exception("Can't invoke method " . __METHOD__ . " on a view");
			}
			
			/**
             * (non-PHPdoc)
			 * @see TechDivision_Model_Interfaces_Entity::update()
			 */
			public function update() 
			{
				throw new Exception("Can't invoke method " . __METHOD__ . " on a view");
			}
			
			/**
             * (non-PHPdoc)
			 * @see TechDivision_Model_Interfaces_Entity::delete()
			 */
			public function delete() 
			{
				throw new Exception("Can't invoke method " . __METHOD__ . " on a view");
			}
			</xsl:if>
		
            <xsl:if test="//entity/tables/table/@type!='View'">
            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Entity::create()
             */
            public function create() 
            {
                // get a new Id and save the entity
                try {
	            	<xsl:for-each select="/entity/tables/table/keys/pk">
	            		<xsl:variable name="sqlname" select="@field"/>
	            		<xsl:if test="/entity/tables/table/fields/field[@name=$sqlname]/@autoincrement='false'">
	            			$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="/entity/members/member[@sqlname=$sqlname]/@name"/> = $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getNextId();
	            		</xsl:if>
	            	</xsl:for-each>
            		<xsl:call-template name="prepare-insert-params"/>
            		$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMasterManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>execute(<xsl:call-template name="create"/>, $params, $paramTypes);
	            	<xsl:for-each select="/entity/tables/table/keys/pk">
	            		<xsl:variable name="sqlname" select="@field"/>
	            		<xsl:choose>
	            			<xsl:when test="/entity/tables/table/fields/field[@name=$sqlname]/@autoincrement='true'">
	            				$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="/entity/members/member[@sqlname=$sqlname]/@name"/> = <xsl:call-template name="create-type"><xsl:with-param name="name" select="/entity/members/member[@sqlname=$sqlname]/@type"></xsl:with-param></xsl:call-template>;
	            			</xsl:when>
	            		</xsl:choose>
	            	</xsl:for-each>
	            	// return the primary key
	            	return $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey();
                } catch(TechDivision_Model_Interfaces_Exception $tmie)	{
                    // if a exception is thrown
                    throw new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Exceptions_<xsl:value-of select="@name"/>CreateException($tmie-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>__toString());
                }
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Entity::update()
             */
            public function update() 
            {
                // update the entity
                try {<xsl:call-template name="prepare-update-params"/>
            		$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMasterManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>execute(<xsl:call-template name="update"/>, $params, $paramTypes);
                    $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>removeBean($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getEntityAlias(), $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey());
                } catch(TechDivision_Model_Interfaces_Exception $tmie)	{
                    // if a exception is thrown
                    throw new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Exceptions_<xsl:value-of select="@name"/>UpdateException($tmie-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>__toString());
                }
            }

            /**
             * (non-PHPdoc)
             * @see TechDivision_Model_Interfaces_Entity::delete()
             */
            public function delete() {
                // delete the entity
                try {
                    <xsl:for-each select="/entity/references/reference">
                    <xsl:if test="multiplicity='one'">
                    <xsl:if test="@delete-cascade='true'">
                    <xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="method-name"/>()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>delete();
                    </xsl:if>
                    </xsl:if>
                    <xsl:if test="multiplicity='many' or multiplicity='many-to-many'">
                    <xsl:if test="@delete-cascade='true'">
                    foreach(<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:value-of select="method-name"/>s() as $entity) { $entity-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>delete(); }
                    </xsl:if>
                    </xsl:if>
                    </xsl:for-each>
                    <xsl:call-template name="prepare-delete-params"/>
            		$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMasterManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>execute(<xsl:call-template name="delete"/>, $params, $paramTypes);
            		$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>removeBean($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getEntityAlias(), $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getPrimaryKey());
                } catch(TechDivision_Model_Interfaces_Exception $tmie)	{
                    // if a exception is thrown
                    throw new <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Exceptions_<xsl:value-of select="@name"/>DeleteException($tmie-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>__toString());
                }
            }
            </xsl:if>
		}
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
	
	<xsl:template name="constants">
		<xsl:for-each select="//entity/tables/table"><xsl:variable name="tablename" select="@name"/>
		<xsl:for-each select="fields/field"><xsl:variable name="name" select="@name"/>
			/**
			 * Holds the field name for member <xsl:value-of select="//entity/members/member[@sqlname= $name]/@name"/>.
			 * @var string
			 */
			const <xsl:call-template name="str:to-upper"><xsl:with-param name="text" select="@name"/></xsl:call-template> = "<xsl:value-of select="$tablename"/>.<xsl:value-of select="@name"/>";
			</xsl:for-each></xsl:for-each>
	</xsl:template>
	
	<xsl:template name="members">
		<xsl:for-each select="/entity/members/member">"<xsl:value-of select="@name"/>" =<xsl:text disable-output-escaping="yes">&gt;</xsl:text> "<xsl:value-of select="@sqlname"/>"<xsl:if test="position()!=last()">, </xsl:if></xsl:for-each>
	</xsl:template>

	<xsl:template name="create">
		<xsl:for-each select="/entity/tables/table">"INSERT INTO `<xsl:value-of select="@name"/>` (<xsl:call-template name="fieldlist"/>) VALUES (<xsl:call-template name="init-insert-values"/>)"</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="update">
		<xsl:for-each select="/entity/tables/table">"UPDATE `<xsl:value-of select="@name"/>` SET <xsl:call-template name="init-update-values"/> WHERE <xsl:call-template name="init-key"/>"</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="delete">
		<xsl:for-each select="/entity/tables/table">"DELETE FROM `<xsl:value-of select="@name"/>` WHERE <xsl:call-template name="init-key"/>"</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="load">
		<xsl:for-each select="/entity/tables/table">"SELECT * FROM `<xsl:value-of select="@name"/>` WHERE <xsl:call-template name="init-key"/>"</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="references">
		<xsl:for-each select="/entity/references/reference">
			<xsl:variable name="memberName" select="target/member-name"/>
			<xsl:choose>
				<xsl:when test="multiplicity='many' or multiplicity='many-to-many'">
					<xsl:choose>
						<xsl:when test="$memberName != ''">
							/**
							 * Returns the
							 *
							 * @return <xsl:value-of select="field/type"/> Holds the
							 */
							public function get<xsl:value-of select="method-name"/>() {
								// if member is null return<xsl:choose>
								<xsl:when test="/entity/members/member[@name=$memberName][@type='Integer']">
								if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>intValue() === 0) {
									return new TechDivision_Collections_ArrayList();
								}</xsl:when>
								<xsl:when test="/entity/members/member[@name=$memberName][@type='String']">
								if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>stringValue() === '') {
									return new TechDivision_Collections_ArrayList();
								}</xsl:when>
								<xsl:when test="/entity/members/member[@name=$memberName][@type='Float']">
								if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>floatValue() === 0) {
									return new TechDivision_Collections_ArrayList()
								} </xsl:when>
								<xsl:when test="/entity/members/member[@name=$memberName][@type='Boolean']">
									return new TechDivision_Collections_ArrayList();
								}</xsl:when>
								<xsl:otherwise>	
								if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/> == null) {
									return new TechDivision_Collections_ArrayList();
								}
								</xsl:otherwise>
								</xsl:choose>
								return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Utils_<xsl:value-of select="source/entity-name"/>Util::getHome($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer())-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findAllBy<xsl:call-template name="capitalize"><xsl:with-param name="text" select="target/member-name"/></xsl:call-template>Fk($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>);
							}
						</xsl:when>
						<xsl:otherwise>
							/**
							 * Returns
							 *
							 * @return <xsl:value-of select="field/type"/> Holds the
							 */
							public function get<xsl:value-of select="method-name"/>() {
								// if member is null return<xsl:choose>
								<xsl:when test="/entity/members/member[@name=$memberName][@type='Integer']">
								if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>intValue() === 0) {
									return new TechDivision_Collections_ArrayList();
								}</xsl:when>
								<xsl:when test="/entity/members/member[@name=$memberName][@type='String']">
								if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>stringValue() === '') {
									return new TechDivision_Collections_ArrayList();
								}</xsl:when>
								<xsl:when test="/entity/members/member[@name=$memberName][@type='Float']">
								if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>floatValue() === 0) {
									return new TechDivision_Collections_ArrayList();
								}</xsl:when>
								<xsl:when test="/entity/members/member[@name=$memberName][@type='Boolean']">
									return new TechDivision_Collections_ArrayList();
								}</xsl:when>
								<xsl:otherwise>	
								if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/> == null) {
									return new TechDivision_Collections_ArrayList();
								}
								</xsl:otherwise>
								</xsl:choose>
				                return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Utils_<xsl:value-of select="source/entity-name"/>Util::getHome($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer())-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/method/@name"/>($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/method/@param"/>);
							}
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="multiplicity='one'">
						/**
						 * Returns the
						 *
						 * @return entity Holds the
						 */
						public function get<xsl:value-of select="method-name"/>() {
							// if member is null return<xsl:choose>
							<xsl:when test="/entity/members/member[@name=$memberName][@type='Integer']">
							if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/> == null) {
								return null;
							}
							if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>intValue() === 0) {
								return null;
							}</xsl:when>
							<xsl:when test="/entity/members/member[@name=$memberName][@type='String']">
							if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/> == null) {
								return null;
							}
							if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>stringValue() === '') {
								return null;
							}</xsl:when>
							<xsl:when test="/entity/members/member[@name=$memberName][@type='Float']">
							if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/> == null) {
								return null;
							}
							if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>floatValue() === 0) {
								return null;
							}</xsl:when>
							<xsl:when test="/entity/members/member[@name=$memberName][@type='Boolean']">
							return null;
							</xsl:when>
							<xsl:otherwise>	
							if ($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/> == null) {
								return null;
							}
							</xsl:otherwise>
							</xsl:choose>
							// else get the related data and return it
			                return <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Utils_<xsl:value-of select="source/entity-name"/>Util::getHome($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer())-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey( $this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="target/member-name"/>);
						}
				</xsl:when>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="fieldlist">
		<xsl:for-each select="/entity/tables/table/fields/field">
			<xsl:variable name="name" select="@name"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					<xsl:choose>
						<xsl:when test="/entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">
								`<xsl:value-of select="@name"/>`
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							`<xsl:value-of select="@name"/>`
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="/entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">
								`<xsl:value-of select="@name"/>`
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							`<xsl:value-of select="@name"/>`
							<xsl:text>, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="values">
		<xsl:for-each select="/entity/tables/table/fields/field">
			<xsl:variable name="name" select="@name"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					<xsl:choose>
						<xsl:when test="/entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">
								<xsl:call-template name="getter">
									<xsl:with-param name="sqlname" select="@name"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="getter">
								<xsl:with-param name="sqlname" select="@name"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="/entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">
								<xsl:call-template name="getter">
									<xsl:with-param name="sqlname" select="@name"/>
								</xsl:call-template>
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="getter">
								<xsl:with-param name="sqlname" select="@name"/>
							</xsl:call-template>
							<xsl:text>, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="init-insert-values">
		<xsl:for-each select="/entity/tables/table/fields/field">
			<xsl:variable name="name" select="@name"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					<xsl:choose>
						<xsl:when test="/entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">? </xsl:if>
						</xsl:when>
						<xsl:otherwise>? </xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="/entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">?, </xsl:if>
						</xsl:when>
						<xsl:otherwise>?, </xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="init-update-values">
		<xsl:for-each select="/entity/tables/table/fields/field">
			<xsl:variable name="name" select="@name"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					<xsl:if test="/entity/tables/table/keys/pk[@field!=$name]">
						`<xsl:value-of select="@name"/>` = ?
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="/entity/tables/table/keys/pk[@field!=$name]">
						`<xsl:value-of select="@name"/>` = ?,
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="init-key">
		<xsl:for-each select="/entity/tables/table/keys/pk">
			<xsl:variable name="field" select="@field"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					`<xsl:value-of select="@field"/>` = ?
				</xsl:when>
				<xsl:otherwise>
					`<xsl:value-of select="@field"/>` = ?
					<xsl:text> AND </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="prepare-update-params">
		$params = array(
		<xsl:for-each select="//entity/tables/table/fields/field">
			<xsl:variable name="name" select="@name"/>
			<xsl:if test="//entity/tables/table/keys/pk[@field!=$name]">
				<xsl:call-template name="getter">
					<xsl:with-param name="sqlname"><xsl:value-of select="@name"/></xsl:with-param>
				</xsl:call-template>
				<xsl:if test="position()!=last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="//entity/tables/table/keys/pk">
			<xsl:variable name="field" select="@field"/>
			<xsl:text>, </xsl:text>
			<xsl:call-template name="getter">
				<xsl:with-param name="sqlname" select="@field"/>
			</xsl:call-template>
		</xsl:for-each>
		);
		$paramTypes = array(
		<xsl:for-each select="//entity/tables/table/fields/field">
			<xsl:variable name="name" select="@name"/>
			<xsl:if test="//entity/tables/table/keys/pk[@field!=$name]">
				"<xsl:value-of select="//entity/members/member[@sqlname=$name]/@type"/>"<xsl:if test="position()!=last()"><xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="//entity/tables/table/keys/pk">
			<xsl:variable name="field" select="@field"/>
			<xsl:text>, </xsl:text> "<xsl:value-of select="//entity/members/member[@sqlname=$field]/@type"/>"
		</xsl:for-each>
		);
	</xsl:template>

	<!--  -->
	<xsl:template name="prepare-delete-params">
		$params = array(
		<xsl:for-each select="//entity/tables/table/keys/pk">
			<xsl:variable name="field" select="@field"/>
			<xsl:call-template name="getter">
				<xsl:with-param name="sqlname" select="@field"/>
			</xsl:call-template>
			<xsl:if test="position()!=last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
		);
		$paramTypes = array(
		<xsl:for-each select="//entity/tables/table/keys/pk">
			<xsl:variable name="field" select="@field"/>
			"<xsl:value-of select="//entity/members/member[@sqlname=$field]/@type"/>"<xsl:if test="position()!=last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
		);
	</xsl:template>

	<!--  -->
	<xsl:template name="prepare-insert-params">
		$params = array(
		<xsl:for-each select="//entity/tables/table/fields/field">
			<xsl:variable name="name" select="@name"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					<xsl:choose>
						<xsl:when test="//entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">
								<xsl:call-template name="getter">
									<xsl:with-param name="sqlname" select="@name"/>
								</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="getter">
								<xsl:with-param name="sqlname" select="@name"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="//entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">
								<xsl:call-template name="getter">
									<xsl:with-param name="sqlname" select="@name"/>
								</xsl:call-template>
								<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="getter">
								<xsl:with-param name="sqlname" select="@name"/>
							</xsl:call-template>
							<xsl:text>, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		);
		$paramTypes = array(
		<xsl:for-each select="//entity/tables/table/fields/field">
			<xsl:variable name="name" select="@name"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					<xsl:choose>
						<xsl:when test="//entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">
								"<xsl:value-of select="//entity/members/member[@sqlname=$name]/@type"/>"
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							"<xsl:value-of select="//entity/members/member[@sqlname=$name]/@type"/>"
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="//entity/tables/table/keys/pk[@field=$name]">
							<xsl:if test="@autoincrement!='true'">
								"<xsl:value-of select="//entity/members/member[@sqlname=$name]/@type"/>"<xsl:text>, </xsl:text>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							"<xsl:value-of select="//entity/members/member[@sqlname=$name]/@type"/>"<xsl:text>, </xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		);
	</xsl:template>

	<!--  -->
	<xsl:template name="key">
		<xsl:for-each select="/entity/tables/table/keys/pk">
			<xsl:value-of select="@field"/> = " . <xsl:call-template name="getter"><xsl:with-param name="sqlname" select="@field"/></xsl:call-template> . "
			<xsl:if test="position()!=last()">
				<xsl:text> AND </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="entitykeys">
		<xsl:for-each select="/entity/tables/table/keys/pk">
			<xsl:variable name="sqlname" select="@field"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="/entity/members/member[@sqlname=$sqlname]/@name"/>
				</xsl:when>
				<xsl:otherwise>
					$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="/entity/members/member[@sqlname=$sqlname]/@name"/>
					<xsl:text>, </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="params">
		<xsl:for-each select="/entity/tables/table/fields/field">
			<xsl:choose>
				<xsl:when test="position()=last()">
					$<xsl:value-of select="@name"/> = null
				</xsl:when>
				<xsl:otherwise>
					$<xsl:value-of select="@name"/>
					<xsl:text disable-output-escaping="yes"> = null, </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="deleteparams">
		<xsl:for-each select="/entity/tables/table/keys/pk">
			<xsl:variable name="sqlname" select="@name"/>
			<xsl:choose>
				<xsl:when test="position()=last()">
					$<xsl:value-of select="/entity/members/member[@sqlname=$sqlname]/@name"/>
				</xsl:when>
				<xsl:otherwise>
					$<xsl:value-of select="/entity/members/member[@sqlname=$sqlname]/@name"/>
					<xsl:text disable-output-escaping="yes">, </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--Initializes the light value object with the apropriate data-->
	<xsl:template name="initlvo">
		<xsl:for-each select="/entity/members/member">
			<xsl:choose>
				<xsl:when test="position()=last()">
					$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
					<xsl:value-of select="@name"/>
				</xsl:when>
				<xsl:otherwise>
					$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text disable-output-escaping="yes">, </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

	<!--Initializes the value object with the apropriate data-->
	<xsl:template name="initvo">
		<xsl:for-each select="/entity/members/member">
			$vo-<xsl:text disable-output-escaping="yes">&gt;set</xsl:text>
			<xsl:call-template name="capitalize">
				<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>($this-<xsl:text disable-output-escaping="yes">&gt;get</xsl:text>
			<xsl:call-template name="capitalize">
				<xsl:with-param name="text" select="@name"/>
			</xsl:call-template>());
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="getter">
		<xsl:param name="sqlname"/>
		$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="/entity/members/member[@sqlname=$sqlname]/@name"/>
	</xsl:template>

	<!--  -->
	<xsl:template name="include-references">
		<xsl:for-each select="/entity/references/reference">
            <!--
			 | The variable $include_path_ ... is the ouput path
			 | of the plugin configuration
			 -->
			require_once "<xsl:value-of select="$include_path_utils"/><xsl:value-of select="source/entity-name"/>Util.php";
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="include-interfaces">
		<xsl:for-each select="//entity/interfaces/interface">
            <!--
			 | The variable $include_path_ ... is the ouput path
			 | of the plugin configuration
			 -->
			require_once "<xsl:value-of select="@include"/>"
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="construct-params">
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

	<!--  -->
	<xsl:template name="construct">
		<xsl:for-each select="members/member">
			$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text><xsl:value-of select="@name"/> = $<xsl:value-of select="@name"/>;
		</xsl:for-each>
	</xsl:template>

	<!--  -->
	<xsl:template name="initialize-with-pk">
		<xsl:for-each select="/entity/tables/table/fields/field">
			<xsl:variable name="sqlname" select="@name"/>
			$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>set<xsl:call-template name="capitalize"><xsl:with-param name="text" select="/entity/members/member[@sqlname=$sqlname]/@name"/></xsl:call-template>($mapping-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>get<xsl:call-template name="capitalize"><xsl:with-param name="text" select="/entity/members/member[@sqlname=$sqlname]/@name"/></xsl:call-template>());
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
	
	<xsl:template name="new-type">
		<xsl:param name="name"/>
		<xsl:param name="initial"/>
		<xsl:choose>
			<xsl:when test="$name='String'">new TechDivision_Lang_String(<xsl:if test="$initial!='null'"><xsl:value-of select="$initial"/></xsl:if>)</xsl:when>
			<xsl:when test="$name='Integer'"><xsl:choose><xsl:when test="$initial!='null'">new TechDivision_Lang_Integer(<xsl:value-of select="$initial"/>)</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose></xsl:when>
			<xsl:when test="$name='Float'"><xsl:choose><xsl:when test="$initial!='null'">new TechDivision_Lang_Float(<xsl:value-of select="$initial"/>)</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose></xsl:when>
			<xsl:when test="$name='Boolean'"><xsl:choose><xsl:when test="$initial!='null'">new TechDivision_Lang_Boolean(<xsl:value-of select="$initial"/>)</xsl:when><xsl:otherwise>null</xsl:otherwise></xsl:choose></xsl:when>
			<xsl:otherwise><xsl:value-of select="$initial"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="create-type">
		<xsl:param name="name"/>
		<xsl:choose>
			<xsl:when test="$name='String'">new <xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMasterManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getLastInsertId()))</xsl:when>
			<xsl:when test="$name='Integer'"><xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>::valueOf(new TechDivision_Lang_String($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMasterManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getLastInsertId()))</xsl:when>
			<xsl:when test="$name='Float'"><xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>::valueOf(new TechDivision_Lang_String($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMasterManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getLastInsertId()))</xsl:when>
			<xsl:when test="$name='Boolean'"><xsl:call-template name="type"><xsl:with-param name="name" select="$name"/></xsl:call-template>::valueOf(new TechDivision_Lang_String($this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMasterManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getLastInsertId()))</xsl:when>
			<xsl:otherwise>$this-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getContainer()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getMasterManager()-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getLastInsertId()</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>