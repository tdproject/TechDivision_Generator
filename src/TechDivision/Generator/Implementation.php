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

/**
 * This is the main generator class, that initializes the
 * configuration and executes the plugins.
 *
 * @package TechDivision_Generator
 * @author Tim Wagner <t.wagner@techdivision.com>
 * @copyright TechDivision GmbH
 * @link http://www.techdivision.com
 * @license GPL
 */
class TechDivision_Generator_Implementation
{

    /**
     * Holds an array with all plugins specified in the configuration file.
     * @var array
     */
    private $_plugins = array();

    /**
     * Holds the name and the path to the configuration file.
     * @var string
     */
    private $_configFile = null;

    /**
     * The construct passes the information necessary to run the
     * plugins.
     *
     * @param string $configFile
     * 		Holds the name and the path to the configuration file
     * @return void
     */
    public function __construct($configFile)
    {
        $this->_configFile = $configFile;
    }

    /**
     * This method loads the configuration file with the
     * SimpleXML extensionsa and initializes the plugins
     * with the specified information.
     *
     * @return void
     */
    public function initialize()
    {
        // inititalize the configuration
        $sxe = new SimpleXMLElement(
            file_get_contents(
                $this->_configFile,
                true
            )
        );
        // initialize the namespace and the module
        foreach ($sxe->xpath('/conf') as $root) {

            $attributes = $root->attributes();

            $namespace = $attributes['namespace'];
            $module = $attributes['module'];
            // initialize the array for the includes
            $includes = array();
            // initialize the includes
            foreach ($root->xpath('includes/include') as $include) {
                $attributes = $include->attributes();
                $includes[(string) $attributes['id']] = (string) $include;
            }
            // load and initialize the plugins
            foreach ($root->xpath('plugins/plugin') as $configuration) {
                $attributes = $configuration->attributes();
                require_once $attributes['include'];
                $reflectionClass = new ReflectionClass(
                    (string) $attributes['type']
                );
                $plugin = $reflectionClass->newInstance(
                    $configuration,
                    $namespace,
                    $module
                );
                $plugin->initialize($includes);
                $this->_plugins[] = $plugin;
            }
        }
    }

    /**
     * This method invokes the generate() method of all specified
     * plugins.
     *
     * @return void
     */
    public function generate()
    {
        // invoke the generate() method of each plugin
        for ($i = 0; $i < sizeof($this->_plugins); $i++) {
            $this->_plugins[$i]->generate();
            echo 'Successfully generated files for plugin '
                . $this->_plugins[$i]->getName()
                . PHP_EOL;
        }
    }
}