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

require_once 'PHPUnit/Extensions/Database/TestCase.php';
require_once 'TechDivision/Generator/Implementation.php';
require_once 'TechDivision/Model/Container/Implementation.php';
require_once 'TechDivision/Model/Manager/MySQLi.php';
require_once 'TechDivision/Util/XMLDataSource.php';

/**
 * This is the test for the Integer class.
 *
 * @package TechDivision_Generator
 * @author Tim Wagner <t.wagner@techdivision.com>
 * @copyright TechDivision GmbH
 * @link http://www.techdivision.com
 * @license GPL
 */
class TechDivision_Generator_ImplementationTest
    extends PHPUnit_Extensions_Database_TestCase {

    public static function setUpBeforeClass()
    {
		$generator = new TechDivision_Generator_Implementation(
			'TechDivision/Generator/META-INF/generator.xml'
		);

        $generator->initialize();
        $generator->generate();
    }

    public function setUp()
    {
		require_once 'TechDivision/Model/Configuration/XML.php';

		$this->_container = TechDivision_Model_Container_Implementation::getContainer(
			md5(time()),
			$configuration = TechDivision_Model_Configuration_XML::getConfiguration(
				'TechDivision/Generator/META-INF/deployment-descriptor.xml'
			)
		);
    }

    public function tearDown()
    {
		$this->_container = null;
    }

    protected function _getContainer()
    {
    	return TechDivision_Model_Container_Implementation::getContainer();
    }


    protected function getConnection()
    {
    	$ds = TechDivision_Util_XMLDataSource::createByName(
        	$dataSourceName = 'test',
            'TechDivision/Generator/META-INF/ds.xml'
        );

        $pdo = new PDO(
        	'mysql:host=' . $ds->getHost() . ';dbname=' . $ds->getDatabase(),
        	$ds->getUser(),
        	$ds->getPassword()
        );

        return $this->createDefaultDBConnection($pdo, $ds->getDatabase());
    }

    /**
     * Returns the test dataset.
     *
     * @return PHPUnit_Extensions_Database_DataSet_IDataSet
     */
    protected function getDataSet()
    {
    	return $this->createXMLDataSet(
    		'TechDivision/Generator/META-INF/flat-data.xml'
    	);
    }

	/**
	 * This is a dummy test.
	 *
	 * @return void
	 */
	function testCreate()
	{

		require_once 'TechDivision/Generator/Model/Utils/UserUtil.php';

		$user = TechDivision_Generator_Model_Utils_UserUtil::getHome()
			->epbCreate();

		$user->setFirstname($firstname = 'Tim');
		$user->setLastname($lastname = 'Wagner');
		$user->setEmail($email = 'tw@techdivision.com');
		$user->setUsername($username = 'wagnert');
		$user->setPassword($password = 'test');

		try {
			$this->_getContainer()->getMasterManager()->beginTransaction();
			$userId = $user->create();
			$this->_getContainer()->getMasterManager()->commitTransaction();
		} catch (Exception $e) {
			$this->_getContainer()->getMasterManager()->rollbackTransaction();
			$this->fail($e->__toString());
		}

		$us = TechDivision_Generator_Model_Utils_UserUtil::getHome()
			->findByPrimaryKey(new TechDivision_Lang_Integer($userId));

		$this->assertEquals($userId, $us->getUserId());
		$this->assertEquals($firstname, $us->getFirstname());
		$this->assertEquals($lastname, $us->getLastname());
		$this->assertEquals($email, $us->getEmail());
		$this->assertEquals($username, $us->getUsername());
		$this->assertEquals($password, $us->getPassword());
	}

	public function testUpdate()
	{

		require_once 'TechDivision/Generator/Model/Utils/UserUtil.php';

		$user = TechDivision_Generator_Model_Utils_UserUtil::getHome()
			->findByPrimaryKey(new TechDivision_Lang_Integer(1));

		$user->setFirstname($firstname = 'Hans');
		$user->setLastname($lastname = 'Mustermann');
		$user->setEmail($email = 'hm@techdivision.com');
		$user->setUsername($username = 'mustermannh');
		$user->setPassword($password = 'muster');

		try {
			$this->_getContainer()->getMasterManager()->beginTransaction();
			$userId = $user->update();
			$this->_getContainer()->getMasterManager()->commitTransaction();
		} catch (Exception $e) {
			$this->_getContainer()->getMasterManager()->rollbackTransaction();
			$this->fail($e->__toString());
		}

		$us = TechDivision_Generator_Model_Utils_UserUtil::getHome()
			->findByPrimaryKey($userId = new TechDivision_Lang_Integer(1));

		$this->assertEquals($userId->intValue(), $us->getUserId());
		$this->assertEquals($firstname, $us->getFirstname());
		$this->assertEquals($lastname, $us->getLastname());
		$this->assertEquals($email, $us->getEmail());
		$this->assertEquals($username, $us->getUsername());
		$this->assertEquals($password, $us->getPassword());

	}

	public function testDelete()
	{

		require_once 'TechDivision/Generator/Model/Utils/UserUtil.php';

		$user = TechDivision_Generator_Model_Utils_UserUtil::getHome()
			->findByPrimaryKey($userId = new TechDivision_Lang_Integer(1));

		try {
			$this->_getContainer()->getMasterManager()->beginTransaction();
			$user->delete();
			$this->_getContainer()->getMasterManager()->commitTransaction();
		} catch (Exception $e) {
			$this->_getContainer()->getMasterManager()->rollbackTransaction();
			$this->fail($e->__toString());
		}

		try {

			TechDivision_Generator_Model_Utils_UserUtil::getHome()
				->findByPrimaryKey($userId);

			$this->fail('Expected UserFindException has not been thrown!');

		} catch(TechDivision_Generator_Model_Exceptions_UserFindException $e) {
		}
	}
}