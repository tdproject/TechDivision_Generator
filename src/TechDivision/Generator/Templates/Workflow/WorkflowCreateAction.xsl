<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output indent="yes" encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:param name="include_path_utils"/>
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		<xsl:variable name="className"><xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Workflow_<xsl:value-of select="@name"/>CreateAction</xsl:variable>
		
		require_once "TechDivision/Workflow/Interfaces/Data.php";
		require_once "TechDivision/Workflow/Interfaces/Action.php";
		require_once "<xsl:value-of select="$include_path_utils"/><xsl:call-template name="str:to-lower"><xsl:with-param name="text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template>util.php";
		
        /**
		 * This action creates a new entry for the <xsl:value-of select="@name"/>LightValue
		 * passed in the workflow data.
         * 
         * @package Model
         * @subpackage Workflow
         * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
         * @version $Revision: 1.1 $ $Date: 2007-10-25 16:09:14 $
         * @copyright TechDivision GmbH
         * @link http://www.techdivision.com 
         */
		class <xsl:value-of select="$className"/> implements TechDivision_Workflow_Interfaces_Action {
		
			/**
			 * This method creates the new entry 
			 * in the database.
			 * 
			 * @param WorkflowData $data Holds the WorkflowData necessary for the workflow
			 */					
			public function execute(TechDivision_Workflow_Data $data) {
				// getting the workflow data
				$lvo = $data-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getProperty("lvo");
				// create the new entry
				$id = <xsl:value-of select="$namespace"/>_<xsl:value-of select="$module"/>_Model_Utils_<xsl:value-of select="@name"/>Util::getHome()
					-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>create($lvo);
				// set the id in the workflow data
				$data-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>setProperty("data", $id);
			}			
	    }
		
    </xsl:template>
</xsl:stylesheet>