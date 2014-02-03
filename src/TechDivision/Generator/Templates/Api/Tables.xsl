<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    						  xmlns:str="http://xsltsl.org/string"
     						  xmlns:php="http://php.net/xsl">
    
    <xsl:output indent="yes" encoding="UTF-8" method="html"/>
    
    <xsl:include href="../Utils/Utils.xsl"/>
    
    <xsl:template match="entity">
        <html>
            <head>
                <title>Details for entity <xsl:value-of select="@name"/></title>
            </head>
            <body>
                <table border="1" width="800">
                    <tr>
                        <td>
                            <xsl:value-of select="description"/>
                        </td>
                    </tr>
                </table>
                <br/>
                <table border="1" width="800">
                    <tr>
                        <td>
                            <h3>Attributname</h3>
                        </td>
                        <td>
                            <h3>Datentyp</h3>
                        </td>
                        <td>
                            <h3>SQL Spaltenname</h3>
                        </td>
                        <td>
                            <h3>SQL Datentyp</h3>
                        </td>
                        <td>
                            <h3>SQL Spaltenlänge</h3>
                        </td>
                    </tr>
                    <xsl:for-each select="members/member">
                        <tr>
                            <td>
                                <xsl:value-of select="@name"/>
                            </td>
                            <td>
                                <xsl:value-of select="@type"/>
                            </td>
                            <td>
                                <xsl:value-of select="@sqlname"/>
                            </td>
                            <td>
                                <xsl:call-template name="type">
                                    <xsl:with-param name="sqlname">
                                        <xsl:value-of select="@sqlname"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </td>
                            <td>
                                <xsl:call-template name="length">
                                    <xsl:with-param name="sqlname">
                                        <xsl:value-of select="@sqlname"/>
                                    </xsl:with-param>
                                </xsl:call-template>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <br/>
                <table border="1" width="800">
                    <xsl:for-each select="querys/query">
                        <tr>
                            <td>Methodenname</td>
                            <td>
                                <xsl:value-of select="method/@name"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Beschreibung</td>
                            <td>
                                <xsl:value-of select="description"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Rückgabetyp</td>
                            <td>
                                <xsl:value-of select="result-type"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">SQL Statement</td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <xsl:value-of select="sql"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br/>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <br/>
                <table border="1" width="800">
                    <xsl:for-each select="references/reference">
                        <tr>
                            <td>Name</td>
                            <td>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:call-template name="str:to-lower">
                                            <xsl:with-param name="text"><xsl:value-of
                                                  select="source/entity-name"
                                            />.html</xsl:with-param>
                                        </xsl:call-template>
                                    </xsl:attribute>
                                    <xsl:value-of select="@name"/>
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td>Multiplicity</td>
                            <td>
                                <xsl:value-of select="multiplicity"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Ziel</td>
                            <td>
                                <xsl:value-of select="source/entity-name"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Feldname</td>
                            <td>
                                <xsl:value-of select="field/name"/>
                            </td>
                        </tr>
                        <tr>
                            <td>Feldtyp</td>
                            <td>
                                <xsl:value-of select="field/type"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"> </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
    <!--
     | This template returns the sql datatype
     | from the xml structure.
     -->
    <xsl:template name="type">
        <xsl:param name="sqlname"/>
        <xsl:value-of select="/entity/tables/table/fields/field[@name=$sqlname]/@type"/>
    </xsl:template>
    <!--
     | This template returns the column length
     | from the xml structure.
     -->
    <xsl:template name="length">
        <xsl:param name="sqlname"/>
        <xsl:value-of select="/entity/tables/table/fields/field[@name=$sqlname]/@length"/>
    </xsl:template>
</xsl:stylesheet>
