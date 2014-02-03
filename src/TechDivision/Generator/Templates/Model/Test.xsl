<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		abstract class Abstract<xsl:value-of select="@name"/>Test extends EPBTestSetup {

			public function __construct($name) {
				// call the constructor of the superclass
				EPBTestSetup::__construct($name);
			}
									
			/**
			 * This method tests the create method of the <xsl:value-of select="@name"/> object.
			 *
			 * @return void
			 */
			public abstract function testCreate();
			
			/**
			 * This method tests the update method of the <xsl:value-of select="@name"/> entity.
			 *
			 * @return void
			 */
			public abstract function testUpdate();

			/**
			 * This method tests the delete method of the <xsl:value-of select="@name"/> entity.
			 *
			 * @return void
			 */
			public abstract function testDelete();
		}
		<xsl:text disable-output-escaping="yes">?&gt;</xsl:text>
	</xsl:template>
</xsl:stylesheet>