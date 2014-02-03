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
class TechDivision_Generator_Plugins_Namespace
    extends TechDivision_Generator_Plugins_Default 
{

    /**
     * @see TechDivision_Generator_Interfaces_Plugin::generate()
     */
    public function generate()
    {
        try {
            // initialize the stylesheet
            $stylesheet = new DomDocument();
            $stylesheet->load($this->_xsl);
            // import the stylesheet
            $this->_processor->importStyleSheet($stylesheet);
            // check if the specified directory exists
            if (is_dir(trim($this->_input))) {
                // open the input dir
                $handle = opendir($this->_input);
                // running over all xml files and transform them
                // with the stylesheet
                while ($file = readdir($handle)) {
                    $isEqual = strcmp(
	                    '.xml',
                        substr(
                            $file,
                            strlen($file) - 4,
                            4
                        )
                    );
                    // if the filename equals
                    if ($isEqual == 0) {
                        $xml = new DomDocument();
                        $xml->load($this->_input . $file);
                        // get the entity name
                        $elements = $xml->getElementsByTagName('entity');
                        foreach ($elements as $storable) {
                            $entity = $storable->getAttribute('name');
                        }
                        
                        $filename = $this->_prefix
                        	. substr($file, 0, strlen($file) - 4)
                        	. $this->_suffix;
                        
                        $outputFile = str_replace('*', $filename, $this->_output)         
	                        . "."
	                        . $this->_ext;
                        
                        // initialize the directory for the generated filed to be stored
                        $dir = dirname($outputFile);
                        
                        // check if the directory exists
                        if (!is_dir($dir)) {
	                        // if not, create it
	                        mkdir($dir, 0755, true);
                        }
                        
                        // generating php code
                        $content = $this->_processor->transformToURI(
                            $xml,
                            $outputFile
                        );
                    }
                }
            }
        } catch(Exception $e) {
            throw new TechDivision_Generator_Exceptions_GeneratorException(
                $e->__toString()
            );
        }
    }
}