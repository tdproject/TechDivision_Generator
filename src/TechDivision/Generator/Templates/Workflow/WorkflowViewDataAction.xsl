<?xml version="1.0" encoding="UTF-8"?>
<!-- Externe DTD einbinden -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
     						  
	<xsl:output indent="yes" encoding="UTF-8" method="html"/>
	<xsl:include href="../Utils/Utils.xsl"/>
	<xsl:param name="include_path_assembler"/>
	<xsl:template match="entity">
		<xsl:text disable-output-escaping="yes">&lt;?php</xsl:text>
		
		require_once "workflow/interfaces/workflowdata.php";
		require_once "workflow/interfaces/workflowaction.php";
		require_once "<xsl:value-of select="$include_path_assembler"/><xsl:call-template name="str:to-lower"><xsl:with-param name="text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template>voassembler.php";
		
        /**
		 * This action adds the <xsl:value-of select="@name"/>Value
		 * with the id passed to the workflow data.
         * 
         * @package epb
         * @subpackage workflow
         * @author generator <xsl:text disable-output-escaping="yes">&lt;</xsl:text>core@techdivision.com<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
         * @version $Revision: 1.1 $ $Date: 2007-10-25 16:09:14 $
         * @copyright TechDivision GmbH
         * @link http://www.techdivision.com 
         */
		class <xsl:value-of select="@name"/>ViewDataAction implements WorkflowAction {
		
			/**
			 * This method gets the <xsl:value-of select="@name"/>Value from
			 * the database and adds it to the workflow data.
			 * 
			 * @param WorkflowData $data Holds the WorkflowData necessary for the workflow
			 */					
			final public function execute(WorkflowData $data) {
				// getting the workflow data
				$id = $data-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>getProperty("<xsl:call-template name="str:to-lower"><xsl:with-param name="text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template>Id");
				// initialize a new VOAssembler
				$assembler = new <xsl:value-of select="@name"/>VOAssembler();
				// get the value object
				$vo = $assembler-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>findByPrimaryKey($id);
				// set the value object in the workflow data
				$data-<xsl:text disable-output-escaping="yes">&gt;</xsl:text>setProperty("data", $vo);
			}			
	    }
		
	    <xsl:text disable-output-escaping="yes">?&gt;</xsl:text>			
    </xsl:template>
</xsl:stylesheet>