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
 * This is the interface for all plugins
 * executed by the generator.
 *
 * @package TechDivision_Generator
 * @author Tim Wagner <t.wagner@techdivision.com>
 * @copyright TechDivision GmbH
 * @link http://www.techdivision.com
 * @license GPL
 */
interface TechDivision_Generator_Interfaces_Plugin
{

    /**
     * This method starts the generation process
     * for the plugin.
     *
     * @return void
     */
    public function generate();

    /**
     * This method return the name of the
     * actual plugin.
     *
     * @return string Holds the name of the actual plugin
     */
    public function getName();

    /**
     * This method initializes the actual
     * plugin with the information from
     * the configuration file.
     *
     * @param array $includes
     * 		Holds an array with the global include informations
     * @return void
     */
    public function initialize(array $includes = array());
}