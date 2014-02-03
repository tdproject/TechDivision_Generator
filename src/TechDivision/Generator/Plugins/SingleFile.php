<?php

/**
 * License: GNU General Public License
 *
 * Copyright (c) 2009 TechDivision GmbH.  All rights reserved.
 * Note: Original work copyright to respective authors
 *
 * This file is part of TechDivision GmbH - Connect.
 *
 * TechDivision_Generator is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * TechDivision_Generator is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
 * USA.
 *
 * @package TechDivision_Generator
 */

require_once 'TechDivision/Generator/Interfaces/Plugin.php';
require_once 'TechDivision/Generator/Exceptions/GeneratorException.php';

/**
 * This plugins loads the xml file specified in the
 * configuration file and transform it with the
 * also specified xslt stylesheet.
 *
 * @package TechDivision_Generator
 * @author Tim Wagner <t.wagner@techdivision.com>
 * @copyright TechDivision GmbH
 * @link http://www.techdivision.com
 * @license GPL
 */
class TechDivision_Generator_Plugins_SingleFile
    extends TechDivision_Generator_Plugins_Default {

    /**
     * Holds the path to the output template with the placeholders.
     * @var string
     */
    protected $_outputTemplate = null;

    /**
     * @see TechDivision_Generator_Interfaces_Plugin::initialize(
     * 			array $includes = array()
     * 		)
     */
    public function initialize(array $includes = array())
    {
        // set the configuration values
        $this->_outputTemplate = (string) $this->_configuration->template;
        // initalize the parent class
        parent::initialize($includes);
    }

    /**
     * @see TechDivision_Generator_Interfaces_Plugin::generate()
     */
    public function generate() {
        try {
            // initialize the stylesheet
            $stylesheet = new DomDocument();
            $stylesheet->load($this->_xsl);
            // import the stylesheet
            $this->_processor->importStyleSheet($stylesheet);
            // initialize the content
            $content = "";
            // explode the output path
            foreach(explode(',', $this->_input) as $input) {
                // check if the specified directory exists
                if(is_dir($directory = trim($input))) {
                    // open the input dir
                    $handle = opendir($directory);
                    // running over all xml files and transform them
                    // with the stylesheet
                    while($file = readdir($handle)) {
                        $isEqual = strcmp(
                            '.xml',
                            substr(
                                $file,
                                strlen($file) - 4,
                                4
                            )
                        );
                        // if the filename equals
                        if($isEqual == 0) {
                            $xml = new DomDocument();
                            $xml->load($input . $file);
                            // generating code
                            $content .= $this->_processor->transformToXML($xml);
                            $xml = null;
                        }
                    }
                }
            }
            // use the template if present
            if(!empty($this->_outputTemplate)){
                $tpl = file_get_contents($this->_outputTemplate);
                $content = str_replace('###PLUGIN_OUTPUT###', $content, $tpl);
            }
            // write the output to the file
            file_put_contents($this->_output, $content, true);
        } catch(Exception $e) {
            throw new TechDivision_Generator_Exceptions_GeneratorException(
                $e->__toString()
            );
        }
    }
}