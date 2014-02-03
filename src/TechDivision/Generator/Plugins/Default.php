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
class TechDivision_Generator_Plugins_Default
    implements TechDivision_Generator_Interfaces_Plugin 
{

    /**
     * The name of the actual plugin.
     * @var string
     */
    protected $_name = null;

    /**
     * Holds XSLTProcessor instance necessary for the transformation process.
     * @var XSLTProcessor
     */
    protected $_processor = null;

    /**
     * The path and the name of the stylesheet to use.
     * @var string
     */
    protected $_xsl = null;

    /**
     * Holds the path to the plugins output directory.
     * @var string
     */
    protected $_output = null;

    /**
     * Holds the path to the plugins input directory.
     * @var string
     */
    protected $_input = null;

    /**
     * Holds the suffix for the plugins output files.
     * @var string
     */
    protected $_suffix = null;

    /**
     * Holds the prefix for the plugins output files.
     * @var string
     */
    protected $_prefix = null;

    /**
     * Holds the file extension for the plugins output files.
     * @var string
     */
    protected $_ext = null;

    /**
     * The path to the configuration file.
     * @var string
     */
    protected $_configuration = null;

    /**
     * The namespace to use.
     * @var string
     */
    protected $_namespace = '';

    /**
     * The module name to use.
     * @var string
     */
    protected $_module = '';

    /**
     * The constructor initializes the XSLTProcessor
     * instance necessary for the transformation and
     * initializes the plugins name and configuration.
     *
     * @param SimpleXMLElement $configuration
     * 		Holds the SimpleXMLElement with the plugins configuration
     * @param string $namespace The namespace to use
     * @param string $module The module name
     * @return void
     */
    public function __construct(
        SimpleXMLElement $configuration,
        $namespace = 'TechDivision',
        $module = 'Default') {
        $attributes = $configuration->attributes();
        $this->_name = (string) $attributes['name'];
        $this->_configuration = $configuration;
        $this->_namespace = $namespace;
        $this->_module = $module;
        // creating a new instance of the XSLT Processor
        $this->_processor = new XSLTProcessor();
        $this->_processor->registerPHPFunctions();
    }

    /**
     * @see TechDivision_Generator_Interfaces_Plugin::getName()
     */
    public function getName()
    {
        return $this->_name;
    }

    /**
     * @see TechDivision_Generator_Interfaces_Plugin::initialize(
     * 			array $includes = array()
     * 		)
     */
    public function initialize(array $includes = array())
    {
        // set the configuration values
        $this->_input = (string) $this->_configuration->input;
        $this->_output = (string) $this->_configuration->output;
        $this->_suffix = (string) $this->_configuration->suffix;
        $this->_prefix = (string) $this->_configuration->prefix;
        $this->_ext = (string) $this->_configuration->ext;
        $this->_xsl = trim((string) $this->_configuration->xsl);
        // if no stylesheet is specified, throw an exception
        if (empty($this->_xsl)) {
            throw new TechDivision_Generator_Exceptions_GeneratorException(
            	   'No stylesheet specified for plugin ' . $this->getName()
            );
        }
        // if no input path is specified, throw an exception
        if (empty($this->_input)) {
            throw new TechDivision_Generator_Exceptions_GeneratorException(
            	   'No input path specified for plugin ' . $this->getName()
            );
        }
        // if no output path is specified, throw an exception
        if (empty($this->_output)) {
            throw new TechDivision_Generator_Exceptions_GeneratorException(
            	   'No output path specified for plugin ' . $this->getName()
            );
        }
        // if no file extension specified, set php as default
        if (empty($this->_ext)) {
            $this->_ext = 'php';
        }
        // set the namespace and the module name
        $this->_processor->setParameter('', 'namespace', $this->_namespace);
        $this->_processor->setParameter('', 'module', $this->_module);
        // add the parameter for the include paths
        foreach ($includes as $id => $include) {
            $this->_processor->setParameter('', $id, $include);
        }
    }

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
                        // create the filename for the generated file
                        $outputFile = $this->_output
                        . $this->_prefix
                        . substr($file, 0, strlen($file) - 4)
                        . $this->_suffix
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